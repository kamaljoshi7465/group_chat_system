module BxBlockGroup
  class GroupConversationsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def index
      @group_conversations = GroupConversation.all
      render json: {
        "all groups": @group_conversations.map do |group|
          {
            "group name" => group.name,
            "group icon" => group.icon,
            "last message" => group.messages.last&.body,
            "message time" => group.messages.last&.created_at
          }
        end
      }, status: :ok
    end 

    def show_group_chat
      begin
      @group_conversation = GroupConversation.find(params[:group_conversation_id])
      render json: { group: GroupConversationSerializer.new(@group_conversation, with_messages: true) }, status: :created
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Group Conversation not found." }, status: :not_found
      end
    end

    def create
      begin
        @group_conversation = GroupConversation.create!(group_conversation_params)        
        # render json: { group: GroupConversationSerializer.new(@group_conversation, with_messages: true) }, status: :created
        render json: { "message": "Group successfully Created" }, staus: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end

    def group_information
      begin
        @group_conversation = GroupConversation.find(params[:group_conversation_id])
        render json: { group_information: GroupConversationSerializer.new(@group_conversation, with_users: true) }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Group Conversation with ID #{params[:group_conversation_id]} not found." }, status: :not_found
      end
    end

    def add_member 
      begin
      @group_conversation = GroupConversation.find(params[:group_conversation_id])
      user = User.find_by(id: params[:user_id])

      if user.nil?
        render json: { error: "User with ID #{params[:user_id]} not found." }, status: :not_found
      else
        if @group_conversation.users.include?(user)
          render json: { error: "User is already a member of the group." }, status: :unprocessable_entity
        else
          @group_conversation.users << user
          render json: { message: "User added to the group conversation successfully." }, status: :ok
        end
      end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Group Conversation with ID #{params[:id]} not found." }, status: :not_found
      end
    end

    def view_schedule
      begin
        @group_conversation = GroupConversation.find(params[:group_conversation_id])
        @user = User.find_by(id: params[:user_id])
        if @user.nil?
          render json: { error: "User with ID #{params[:user_id]} not found." }, status: :not_found
        else
          bookings = @user.bookings.first 
          render json: { view_schedule: BxBlockBooking::BookingSerializer.new(bookings) }, status: :ok
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Group Conversation with ID #{params[:id]}not found." }, status: :not_found
      end
    end

    def remove_member
      begin
      @group_conversation = GroupConversation.find(params[:group_conversation_id  ])
      user = User.find_by(id: params[:user_id])

      if user.nil?
        render json: { error: "User with ID #{params[:user_id]} not found." }, status: :not_found
      elsif !@group_conversation.users.include?(user)
        render json: { error: "User is not a member of the group." }, status: :unprocessable_entity
      else
        @group_conversation.users.delete(user)
        render json: { message: "User successfully removed from the group conversation." }, status: :ok
      end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Group Conversation with ID #{params[:id]} not found." }, status: :not_found
      end
    end

    def delete_group 
      begin
      @group_conversation = GroupConversation.find(params[:group_conversation_id])
      @group_conversation.destroy
      render json: { message: "Group conversation deleted successfully." }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Group Conversation with ID #{params[:id]} not found." }, status: :not_found
      end
    end

    private
    def group_conversation_params
      params.permit(:name, :description, :icon, user_ids: [])
    end
  end
end 