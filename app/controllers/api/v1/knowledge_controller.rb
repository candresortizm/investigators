class Api::V1::KnowledgeController < ApplicationController
  def big_areas_index
    big_areas = BigArea.all
    render json: {data: big_areas}, status: 200
  end

  def knowledge_areas_index
    begin
      ActiveRecord::Base.transaction do
        knowledge_areas = KnowledgeArea.where(big_area_id: params[:big_area_id])
        render json: { data: knowledge_areas}, status: 200
      end
    rescue
      raise
    end
  end

  def speciality_areas_index
    begin
      ActiveRecord::Base.transaction do
        specialities = KnowledgeSpeciality.where(knowledge_area_id: params[:knowledge_area_id])
        render json: { data: specialities}, status: 200
      end
    rescue
      raise
    end
  end
end
