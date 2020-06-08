
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  get "/articles/new" do
    erb :new
  end

  post "/articles" do
    @article = Article.new
    @article.title = params["article"]["title"]
    @article.content = params["article"]["content"]
    @article.save
    redirect "articles/#{@article.id}"
  end

  get "/articles/:id" do
    @article = Article.find(params["id"])
    erb :show
  end

  get "/articles/:id/edit" do
    @article = Article.find(params["id"])
    erb :edit
  end

  patch "/articles/:id" do
    @article = Article.find(params["id"])
    @article.title = params["article"]["title"]
    @article.content = params["article"]["content"]
    @article.save
    redirect "articles/#{@article.id}"
  end

  delete "/articles/:id" do
    tmp = Article.find(params["id"])
    tmp.destroy
    redirect "/articles"
  end
end
