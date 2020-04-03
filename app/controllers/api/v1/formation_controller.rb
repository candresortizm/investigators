class Api::V1::FormationController < ApplicationController
  def formation_levels_index
    all_levels = FormationLevel.all
    render json: {data: all_levels}, status: 200
  end
end
