class GroupsController < ApplicationController
# before_action authenticated_user! :only [:new, :create, :edit, :update, :destroy]
  def index
    @groups = Group.all
  end


  private
  def group_params
    params.require(:group).permit(:title, :description,)
  end


end
