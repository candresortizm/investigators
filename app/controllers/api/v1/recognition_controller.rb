class Api::V1::RecognitionController < ApplicationController
  def recognition_levels_index
    recognition_levels = RecognitionLevel.all
    render json: {data: recognition_levels}, status: 200
  end
end
