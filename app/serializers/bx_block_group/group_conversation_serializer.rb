module BxBlockGroup
  class GroupConversationSerializer < ActiveModel::Serializer
    attributes :id, :name, :icon, :members
    attribute :users, if: -> { @instance_options[:with_users] } 
    attribute :description, if: -> { @instance_options[:with_users] } 

    def members
      object.users.count
    end

    def users 
      object.users.map do |user|
        {
          id: user.id,
          full_name: user.full_name,
          image: user.image
        }
      end
    end
    has_many :messages, serializer: BxBlockGroup::MessageSerializer, if: -> { @instance_options[:with_messages] }
  end 
end