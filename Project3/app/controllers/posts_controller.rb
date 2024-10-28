class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.order(created_at: :desc)
  end

  # GET /posts/:id
  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :asc)
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created successfully."
      redirect_to @post
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :new
    end
  end

  # GET /posts/:id/edit
  def edit
  end

  # PATCH/PUT /posts/:id
  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated successfully."
      redirect_to @post
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: 'Post was successfully deleted.'
    else
      redirect_to posts_path, alert: 'You are not authorized to delete this post.'
    end
  end
  

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:content)
  end

  # Ensure that only the author can edit or delete the post.
  def authorize_user!
    unless @post.user == current_user
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to posts_path
    end
  end
end
