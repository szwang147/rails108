class GroupsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
before_action :check_group_and_permission, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
      flash[:notice] = "create"
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(page: params[:page], per_page: 4)
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path,
      flash[:warning] = "update"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
    flash[:alert] = "delete"
  end

  def join
    @group = Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "welcome add this group"
    else
      flash[:alert] = "you already been the team member"
    end
    redirect_to group_path(@group)
  end


  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:notice] = "quit this group"
    else
      flash[:alert] = "you are not team member how to quit"
    end
    redirect_to group_path(@group)
  end



  private
  def check_group_and_permission
    @group = Group.find(params[:id])
    if current_user != @group.user
      redirect_to groups_path
      flash[:alert] = "you have no permission"
    end
  end

  def group_params
    params.require(:group).permit(:title, :description,)
  end


end
