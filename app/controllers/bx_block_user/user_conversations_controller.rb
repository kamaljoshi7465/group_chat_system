module BxBlockUser 
    class UserConversationsController < ApplicationController
        skip_before_action :verify_authenticity_token
        def mute_chat
            begin
            @group_conversation = GroupConversation.find(params[:group_conversation_id])
            user = User.find_by(id: params[:user_id])
            @user_conversation = @group_conversation.user_conversations.find_by(user_id: user.id)

                case params[:duration]
                    when '8_hours'
                    @user_conversation.mute!(:eight_hours)
                    when '24_hours'
                    @user_conversation.mute!(:twenty_four_hours)
                    when 'always'
                    @user_conversation.mute!(:always)
                else  
                    return render json: { errors: [{ duration: "Invalid mute duration" }] }, status: :unprocessable_entity
                end 

                render json: { message: "Group Conversation has been muted for #{params[:duration]} hours." }, status: :ok
            rescue ActiveRecord::RecordNotFound
                render json: { error: "Group Conversation with ID #{params[:group_conversation_id]} not found." }, status: :not_found
            end
        end
    end
end 