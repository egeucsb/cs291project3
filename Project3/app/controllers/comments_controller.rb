class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_post
  before_action :set_comment, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

  # POST /posts/:post_id/comments
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment added successfully."
      redirect_to @post
    else
      flash[:alert] = @comment.errors.full_messages.join(", ")
      redirect_to @post
    end
  end

  # DELETE /posts/:post_id/comments/:id
  def destroy
    @comment.destroy
    flash[:notice] = "Comment deleted successfully."
    redirect_to @post
  end

  private

  # Set the post based on the post_id parameter
  def set_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  # Set the comment based on the id parameter
  def set_comment
    @comment = @post.comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content)
  end

  # Ensure that only the author can delete the comment.
  def authorize_user!
    unless @comment.user == current_user
      flash[:alert] = "You are not authorized to delete this comment."
      redirect_to @post
    end
  end
end
