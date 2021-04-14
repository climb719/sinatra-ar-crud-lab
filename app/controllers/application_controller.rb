
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  #get all the articles - READ
  get '/articles' do
    @articles = Article.all
    #display the index view
    erb :index
  end

  # view the form to CREATE a new article
  get '/articles/new' do
    @article = Article.new
    # display the new view/i.e. the form 
    erb :new
  end

  # CREATE a new aricle 
  post '/articles' do
    @article = Article.create(params)
    redirect to "/articles/#{@article.id}" # makes a new GET request to see all aricles
  end

    #get 1 artcile 
    get '/articles/:id' do 
      @article = Article.find(params["id"])
      #display the show view of the article 
      erb :show
    end  

  # view the form to UPDATE 1 specific article
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  # UPDATE 1 artcile based on the edit form 
  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"
  end

  #delete one article
  delete "/articles/:id" do
    Article.destroy(params[:id])
    redirect to "/articles"
  end


end
