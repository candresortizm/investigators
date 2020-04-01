Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :formation, controller: :formation do
        get 'formation_levels',to: 'formation#index'
      end
      scope :geographic, controller: :geographic do
        get 'countries',to: 'geographic#countries_index'
        get 'countries/:country_id',to: 'geographic#regions_index'
        get 'regions/:region_id',to: 'geographic#deptos_index'
        get 'deptos/:depto_id',to: 'geographic#municipalities_index'
      end
      scope :knowledge, controller: :knowledge do
        get 'big_areas',to: 'knowledge#big_areas_index'
        get 'big_areas/:big_area_id',to: 'knowledge#knowledge_areas_index'
        get 'knowledge_areas/:knowledge_area_id',to: 'knowledge#speciality_area_index'
      end
      scope :queries, controller: :queries do
        get 'edit/:car_inspection_id',to: 'car_inspections#edit'
      end
      scope :recognition, controller: :recognition do
        get 'recognition_levels',to: 'recognition#recognition_levels_index'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
