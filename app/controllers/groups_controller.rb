class GroupsController < ApplicationController

  def index
    groups = Group.search(params['q'])

    respond_to do |format|
      format.html do
        redirect_to '/'
      end
      format.json {
        render json: groups.as_json(include: [:players, :creator])
      }
    end
  end

  def create
    new_group_params = group_params.merge(creator_id: current_user.id)
    group = Group.create(new_group_params)
    render json: group.as_json(include: [:players, :creator])
  end

  private

  def group_params
    params.require(:group).permit(:mission_name)
  end
end
