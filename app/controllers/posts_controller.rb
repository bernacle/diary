class PostsController < ApplicationController
  before_action :find_posts, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
      flash[:success] = "Post successfully created!"
    else
      flash[:error] = "Post was not created, some error occurred"
      render 'new'
    end
  end

  def edit

  end

  def update
    @post.update(post_params)
    if @post.save && current_user == @post.user
      redirect_to @post
      flash[:success] = "Post successfully updated!"
    else
      flash[:error] = "Post was not updated, some error occurred"
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
    flash[:success] = "Post successfully deleted!"
  end

  private
    def find_posts
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :image)
    end
end
