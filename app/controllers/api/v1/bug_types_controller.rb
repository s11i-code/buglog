class Api::V1::BugTypesController < ApplicationController

  before_action :set_bug_type, only: [:show]
  before_action :set_bug_type_with_authorization, only: [:update, :destroy]

  def index
    @bug_types = BugType.all.includes(:votes)
  end

  def create
    @bug_type = current_user.bug_types.build(bug_type_params)
    if @bug_type.save
      render :show, status: :created, location: api_v1_bug_type_url(@bug_type)
    else
      render json: @bug_type.errors, status: :unprocessable_entity
    end
  end

  def update
    if @bug_type.update(bug_type_params)
      render :show, status: :ok, location: api_v1_bug_type_url(@bug_type)
    else
      render json: @bug_type.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bug_type.destroy
    head :no_content
  end

  private

  def set_bug_type
    @bug_type = BugType.find(params[:id])
  end

  def set_bug_type_with_authorization
    @bug_type = current_user.bug_types.where(id: params[:id]).first
  end

  def bug_type_params
    params.require(:bug_type).permit(:name, :description)
  end

end
