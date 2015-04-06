class Api::V1::VotesController < ApplicationController

  def create
    bug_type = BugType.find(params[:bug_type_id])
    bug_type.votes.create!
    render json: {metadata: { success: true}}
  end

end
