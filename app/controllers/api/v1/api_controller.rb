class Api::V1::ApiController < ApplicationController

  def get_current_user
    render json: current_user.to_json
  end

end
