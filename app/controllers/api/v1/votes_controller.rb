class Api::V1::VotesController < ApplicationController

  def create
    bug_type = BugType.find(params[:bug_type_id])
    current_user.votes.create!(bug_type: bug_type) unless bug_type.voted_by? current_user
    render json: {metadata: { success: true}}
  end

end
