class InformationImporter
  include ActiveModel::Model
  require 'roo'

  def initialize(attributes={})
    @spreadsheet = open_spreadsheet
    @headers = @spreadsheet.row(1)
    @announcement=Announcement.find(1)
    @big_areas=[]
    @countries=[]
    @deptos=[]
    @formation_levels=[]
    @investigators=[]
    @knowledge_areas=[]
    @knowledge_specialities=[]
    @municipalities=[]
    @recognition_investigators=[]
    @recognition_levels=[]
    @regions=[]
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
    Country.import @countries, on_duplicate_key_ignore: true
    Region.import @regions, on_duplicate_key_ignore: true
    Depto.import @deptos, on_duplicate_key_ignore: true
    Municipality.import @municipalities, on_duplicate_key_ignore: true
    BigArea.import @big_areas, on_duplicate_key_ignore: true
    KnowledgeArea.import @knowledge_areas, on_duplicate_key_ignore: true
    KnowledgeSpeciality.import @knowledge_specialities, on_duplicate_key_ignore: true
    FormationLevel.import @formation_levels, on_duplicate_key_ignore: true
    RecognitionLevel.import @recognition_levels, on_duplicate_key_ignore: true
    Investigator.import @investigators, on_duplicate_key_ignore: true
  end

  def build_investigator(row_info)

    recognition_level = build_recognition_class(
              row_info["ID_CLAS_PR"].to_s,
              row_info["NME_CLASIFICACION_PR"],
              row_info["ORDEN_CLAS_PR"],
            )

    level_formation = build_formation_level(
              row_info["ID_NIV_FORMACION_PR"].to_s,
              row_info["NME_NIV_FORMACION_PR"],
              row_info["NRO_ORDEN_FORM_PR"],
            )
    knowledge_specialities = build_area(
              row_info["ID_AREA_CON_PR"],
              row_info["NME_ESP_AREA_PR"],
              row_info["NME_AREA_PR"],
              row_info["NME_GRAN_AREA_PR"]
            )

    # announcement = Announcement.find_by(id_announcement: "20")
    birthplace = build_location(
              row_info["NME_MUNICIPIO_NAC_PR"],
              row_info["NME_DEPARTAMENTO_NAC_PR"],
              row_info["NME_PAIS_NAC_PR"],
              row_info["NME_REGION_NAC_PR"],
              row_info["COD_DANE_NAC_PR"],
              nil
            )
    res_place = build_location(
              row_info["NME_MUNICIPIO_RES_PR"],
              row_info["NME_DEPARTAMENTO_RES_PR"],
              row_info["NME_PAIS_RES_PR"],
              row_info["NME_REGION_RES_PR"],
              row_info["COD_DANE_RES_PR"],
              row_info["ID_UBIC_RES_PR"]
            )
    investigator = Investigator.new(
              birthday: row_info["FNACIMIENTO_PR"],
              gender: row_info["ID_GENERO_PR"],
              birthplace: birthplace,
              current_place: res_place,
              formation_level: level_formation,
              knowledge_speciality: knowledge_specialities
            )
    investigator.recognition_investigators.build(
              announcement: @announcement,
              recognition_level: recognition_level,
              investigator_age: row_info["EDAD_ANOS_PR"]
            )
    @investigators << investigator
  end

  def build_area(id_area, speciality_name, area_name, big_area_name)
    big_area = build_big_area(big_area_name)
    knowledge_area = build_knowledge_area(big_area,area_name,id_area)
    speciality_area = build_speciality_area(knowledge_area,speciality_name)
  end


  def build_big_area(big_area_name)
    if @big_areas.select{ |m|
        m.name==big_area_name
      }.any?
      return @big_areas.select{ |m|
        m.name==big_area_name
      }.first
    else
      big_area = BigArea.where(name: big_area_name).
             first_or_initialize(
              name: big_area_name
             )
      @big_areas << big_area
      return big_area
    end
  end

  def build_knowledge_area(big_area, knowledge_area_name, id_area)
    if @knowledge_areas.select{ |m|
        m.name==knowledge_area_name
      }.any?
      return @knowledge_areas.select{ |m|
        m.name==knowledge_area_name
      }.first
    else
      knowledge_area = KnowledgeArea.where(name: knowledge_area_name).
             first_or_initialize(
              name: knowledge_area_name,
              id_area: id_area
             )
      @knowledge_areas << knowledge_area
      return knowledge_area
    end
  end

  def build_speciality_area(knowledge_area,speciality_name)
    if @knowledge_specialities.select{ |m|
        m.name==speciality_name
      }.any?
      return @knowledge_specialities.select{ |m|
        m.name==speciality_name
      }.first
    else
      speciality = KnowledgeSpeciality.where(name: speciality_name).
             first_or_initialize(
              name: speciality_name
             )
      @knowledge_specialities << speciality
      return speciality
    end
  end

  def build_location(mun_name,depto_name,country_name,reg_name,cod_dane,ubic_res)
    country = build_country(country_name)
    region = build_region(country,reg_name)
    depto = build_depto(region,depto_name)
    build_mun(depto,mun_name,cod_dane,ubic_res)
  end

  def build_country(country_name)
    if @countries.select{ |m|
        m.name==country_name
      }.any?
      return @countries.select{ |m|
        m.name==country_name
      }.first
    else
      country = Country.where(name: country_name).
             first_or_initialize(
              name: country_name
             )
      @countries << country
      return country
    end
  end

  def build_region(country, reg_name)
    if @regions.select{ |m|
        m.name==reg_name && !m.country.nil? && m.country.name==country.name
      }.any?
      return @regions.select{ |m|
        m.name==reg_name && !m.country.nil? && m.country.name==country.name
      }.first
    else
      region = Region.where(name: reg_name).
             first_or_initialize(
              name: reg_name, country: country
             )
      @regions << region
      return region
    end
  end

  def build_depto(region, depto_name)
    if @deptos.select{ |m|
        m.name==depto_name && !m.region.nil? && m.region.name==region.name
      }.any?
      return @deptos.select{ |m|
        m.name==depto_name && !m.region.nil? && m.region.name==region.name
      }.first
    else
      depto = Depto.where(name: depto_name).
             first_or_initialize(
              name: depto_name, region: region
             )
      @deptos << depto
      return depto
    end
  end

  def build_mun(depto, mun_name,mun_dane_code,mun_ubic_res)
    if @municipalities.select{ |m|
        m.name==mun_name && !m.depto.nil? && m.depto.name==depto.name
      }.any?
      return @municipalities.select{ |m|
        m.name==mun_name && !m.depto.nil? && m.depto.name==depto.name
      }.first
    else
      mun = Municipality.where(name: mun_name).
             first_or_initialize(
              name: mun_name,
              depto: depto,
              dane_code: mun_dane_code,
              ubic_res: mun_ubic_res,
             )
      @municipalities << mun
      return mun
    end
  end

  def build_formation_level(id_formation_level, name_formation_level, orden_formation_level)
    if @formation_levels.select{ |m|
        m.id_level==id_formation_level
      }.any?
      return @formation_levels.select{ |m|
        m.id_level==id_formation_level
      }.first
    else
      formation_level = FormationLevel.where(id_level: id_formation_level).
             first_or_initialize(
              name: name_formation_level,
              id_level: id_formation_level,
              order_level: orden_formation_level
             )
      @formation_levels << formation_level
      return formation_level
    end
  end

  def build_recognition_class(id_clas_pr, name_clas_pr, orden_clas_pr)
    if @recognition_levels.select{ |m|
        m.id_clas_pr==id_clas_pr
      }.any?
      return @recognition_levels.select{ |m|
        m.id_clas_pr==id_clas_pr
      }.first
    else
      recognition_level = RecognitionLevel.where(id_clas_pr: id_clas_pr).
             first_or_initialize(
              id_clas_pr: id_clas_pr,
              name_clas_pr: name_clas_pr,
              orden_clas_pr: orden_clas_pr
             )
      @recognition_levels << recognition_level
      return recognition_level
    end
  end

end
