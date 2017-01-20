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
  end

  def update
  end

  def destroy
  end


  def post_params
    params.require(:post).permit(:content)
  end

end
