class Api::V1::DataImportsController < ApplicationController
  def create
    @items_import = InformationImporter.new

  end
end
