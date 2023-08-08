module BxBlockGroup
  class MessagesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
    begin
      @group_conversation = GroupConversation.find(params[:group_conversation_id])
      @message = @group_conversation.messages.create!(message_params)
      # @message = @group_conversation.messages.create!(message_params.merge(user: current_user))
      render json: { "message" => @message} , status: :created
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Group Conversation with ID #{params[:group_conversation_id]} not found." }, status: :not_found
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end

    private
    def message_params
      params.permit(:body, :user_id, :group_conversation_id)
      # params.permit(:body, :group_conversation_id)
    end
  end
end  