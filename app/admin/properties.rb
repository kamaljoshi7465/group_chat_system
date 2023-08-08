ActiveAdmin.register Property do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :property_type, :country, :latitude, :longitude, :address, :location_link, :amenities, :floor_plan_images, :property_images
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :property_type, :country, :latitude, :longitude, :address, :location_link, :amenities, :floor_plan_images, :property_images]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
