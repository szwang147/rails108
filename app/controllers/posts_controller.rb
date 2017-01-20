class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
      flash[:notice] = "create success"
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
  if @post.update(post_params)
    redirect_to account_posts_path
    flash[:notice] = "update post"
  else
    render :edit
  end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
      redirect_to account_posts_path
      flash[:notice] = "delete the post"
  end


  def post_params
    params.require(:post).permit(:content)
  end

end
