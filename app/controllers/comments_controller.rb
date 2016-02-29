class CommentsController < ApplicationController
  before_action :find_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = @post.user_id
    if @comment.save
      redirect_to post_path @post
    else
      flash[:error] = "Error ocurred on creating comment"
    end
  end

  def edit
    
  end

  def update
    @comment = @post.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path @post
    else
      flash[:error] = "Error ocurred on creating comment"
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path @post
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end

    def find_post
      @post = Post.find(params[:post_id])
    end

end
