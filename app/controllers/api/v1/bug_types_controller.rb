class Api::V1::BugTypesController < ApplicationController
  before_action :set_bug_type, only: [:show, :edit, :update, :destroy]

  def index
    #hard-coded placeholder until sign in is fully implemented
    @user = current_user
    @bug_types = BugType.find_all_for(@user)
  end

  def new
    @bug_type = BugType.new
  end

  def create
    @bug_type = BugType.new(bug_type_params)
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

  def bug_type_params
    params.require(:bug_type).permit(:name, :description, :public, :creator_id_id)
  end

end
