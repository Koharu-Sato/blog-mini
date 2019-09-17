class ArticlesController < ApplicationController

  before_action :move_to_session, except: [:index, :show]

  def index
    @articles = Article.all.includes(:user).order("id DESC")
  end

  def new
  end

  def create
    @article = Article.create(title: create_params[:title], content: create_params[:content], user_id: current_user.id)
    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @article = Article.find(id_params[:id])
  end

  def update
    @article = Article.find(id_params[:id])
    @article.update(article_params) if @article.user_id == current_user.id
    if @article.update(article_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy if article.user_id == current_user.id
    if article.destroy
      redirect_to root_path
    end
  end

  private

  def create_params
    params.permit(:title, :content)
  end

  def article_params
    params.require(:article).permit(:title, :content).merge(user_id: current_user.id)
  end

  def id_params
    params.permit(:id)
  end

  def move_to_session
    redirect_to new_user_session_path unless user_signed_in?
  end

end
