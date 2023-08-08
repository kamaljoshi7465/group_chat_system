ActiveAdmin.register User do
  permit_params :first_name, :last_name, :image, :full_name, :DOB, :age, :phone_number, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :image
    column :full_name
    column :DOB
    column :age
    column :phone_number
    column :email
    column :created_at
    actions
  end

  form do |f|
    f.inputs 'User Details' do
      f.input :first_name
      f.input :last_name
      f.input :image
      f.input :full_name
      f.input :DOB, as: :datepicker
      f.input :age
      f.input :phone_number
      f.input :email
      f.input :password
    end
    f.actions
  end
end