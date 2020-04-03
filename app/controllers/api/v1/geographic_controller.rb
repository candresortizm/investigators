class Api::V1::GeographicController < ApplicationController

  def countries_index
    all_countries = Country.all
    render json: {data: all_countries}, status: 200
  end

  def regions_index
    begin
      ActiveRecord::Base.transaction do
        regions = Region.where(country_id: params[:country_id])
        render json: { data: regions}, status: 200
      end
    rescue
      raise
    end
  end

  def deptos_index
    begin
      ActiveRecord::Base.transaction do
        deptos = Depto.where(region_id: params[:region_id])
        render json: { data: deptos}, status: 200
      end
    rescue
      raise
    end
  end

  def municipalities_index
    begin
      ActiveRecord::Base.transaction do
        municipalities = Municipality.where(depto_id: params[:depto_id])
        render json: { data: municipalities}, status: 200
      end
    rescue
      raise
    end
  end

  private

  def region_params
    params.require(:data).permit(
      attributes: Region.get_params
    )
  end

end
