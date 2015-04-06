class Api::V1::VotesController < ApplicationController

  def create
    bug_type = BugType.find(params[:bug_type_id])
    vote = current_user.votes.create!(bug_type: bug_type) unless bug_type.voted_by? current_user
    render json: {metadata: { success: true}, data: vote}
  end

  def destroy
    current_user.votes.find(params[:id]).destroy
    render json: {metadata: { success: true}}
  end

end
