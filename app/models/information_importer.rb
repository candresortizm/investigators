class InformationImporter
  include ActiveModel::Model
  require 'roo'

  def initialize(attributes={})
    @spreadsheet = open_spreadsheet
    @headers = @spreadsheet.row(1)
    load_imported_investigators_data
  end

  def persisted?
    false
  end

  private

  def open_spreadsheet
    Roo::Excelx.new("#{Rails.root}/INVESTIGADORES_RECONOCIDOS_2019.xlsx")
  end

  def load_imported_investigators_data
    (2..@spreadsheet.last_row).each do |row|
      build_investigator(Hash[[@headers, @spreadsheet.row(row)].transpose])
    end
  end

  def build_investigator(row_info)
    # "ID_CONVOCATORIA"=>20.0,
    #  "NME_CONVOCATORIA"=>"Convocatoria 833 de 2018",
    #  "ANO_CONVO"=>Fri, 06 Dec 2019,
    #  "ID_AREA_CON_PR"=>1000000000.0,
    #  "NME_ESP_AREA_PR"=>"Meteorología y Ciencias Atmosféricas",
    #  "NME_AREA_PR"=>"Ciencias de la Tierra y Medioambientales",
    #  "NME_GRAN_AREA_PR"=>"Ciencias Naturales",
    #  "FNACIMIENTO_PR"=>Sat, 21 Apr 2057,
    #  "ID_GENERO_PR"=>"M",
    #  "NME_GENERO_PR"=>"Masculino",
    #  "NME_MUNICIPIO_NAC_PR"=>"Ragonvalia",
    #  "NME_DEPARTAMENTO_NAC_PR"=>"Norte de Santander",
    #  "NME_PAIS_NAC_PR"=>"Colombia",
    #  "NME_REGION_NAC_PR"=>"Centro - Oriente",
    #  "COD_DANE_NAC_PR"=>54599.0,
    #  "ID_UBIC_RES_PR"=>"COL-DC-397",
    #  "NME_MUNICIPIO_RES_PR"=>"Bogotá, D.C.",
    #  "NME_DEPARTAMENTO_RES_PR"=>"Bogotá, D. C.",
    #  "NME_PAIS_RES_PR"=>"Colombia",
    #  "NME_REGION_RES_PR"=>"Distrito Capital",
    #  "COD_DANE_RES_PR"=>11001.0,
    #  "ID_NIV_FORMACION_PR"=>4.0,
    #  "NME_NIV_FORMACION_PR"=>"Doctorado",
    #  "NRO_ORDEN_FORM_PR"=>17.0,
    #  "ID_CLAS_PR"=>"IS",
    #  "NME_CLASIFICACION_PR"=>"Investigador Sénior",
    #  "ORDEN_CLAS_PR"=>12.0,
    #  "EDAD_ANOS_PR"=>61.66
    country = row_info["NME_PAIS_RES_PR"]
  end

end
