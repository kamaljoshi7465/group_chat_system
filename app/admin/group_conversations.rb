ActiveAdmin.register GroupConversation do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :icon, :description, :user_ids
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :icon, :description, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # index do
  #   column :id
  #   column :user_conversations do |group_conversation|
  #     group_conversation.user_conversations.pluck(:users).join(", ")
  #   end
  #   # ... other columns ...
  #   actions
  # end
  
end
