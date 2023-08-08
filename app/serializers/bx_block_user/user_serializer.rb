module BxBlockUser 
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :full_name, :image, :DOB, :age, :phone_number, :email
  end
end 