require 'rails_helper'

RSpec.describe BxBlockGroup::GroupConversationsController, type: :controller do
let(:group_conversation1) { FactoryBot.create(:group_conversation) }
let(:group_conversation2) { FactoryBot.create(:group_conversation) }
let!(:booking) { FactoryBot.create(:booking, user_id: user1.id) }
let!(:message1) { FactoryBot.create(:message, group_conversation: group_conversation1, user: user1) }
let!(:message2) { FactoryBot.create(:message, group_conversation: group_conversation1, user: user2) }
let!(:message3) { FactoryBot.create(:message, group_conversation: group_conversation2) }
let!(:user1) { FactoryBot.create(:user, full_name: "user1") }
let!(:user2) { FactoryBot.create(:user, full_name: "user2") }

  describe 'GET #index' do
    context 'when group conversation exists' do
      it 'returns a list of all group conversations with their last messages' do
        get :index

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['all groups'].length).to eq(2)
        expect(json_response['all groups'][0]['group name']).to eq(group_conversation1.name)
        expect(json_response['all groups'][0]['group icon']).to eq(group_conversation1.icon)
        expect(json_response['all groups'][0]['last message']).to eq(message2.body)
        expect(json_response['all groups'][1]['group name']).to eq(group_conversation2.name)
        expect(json_response['all groups'][1]['group icon']).to eq(group_conversation2.icon)
        expect(json_response['all groups'][1]['last message']).to eq(message3.body)
      end
    end
  end

  describe 'GET #show_group_chat' do
    it 'returns the group conversation details with messages' do
      post :show_group_chat, params: { group_conversation_id: group_conversation1.id }

      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)

      expect(json_response['group']['id']).to eq(group_conversation1.id)
      expect(json_response['group']['name']).to eq(group_conversation1.name)
      expect(json_response['group']['icon']).to eq(group_conversation1.icon)
      expect(json_response['group']['messages']).to be_an(Array)
      expect(json_response['group']['messages'].length).to eq(2)
      expect(json_response['group']['messages'][0]['id']).to eq(message1.id)
      expect(json_response['group']['messages'][0]['body']).to eq(message1.body)
      expect(json_response['group']['messages'][0]['created_at']).to eq(message1.created_at.as_json)
      expect(json_response['group']['messages'][1]['id']).to eq(message2.id)
      expect(json_response['group']['messages'][1]['body']).to eq(message2.body)
      expect(json_response['group']['messages'][1]['created_at']).to eq(message2.created_at.as_json)
    end

    it 'returns an error if the group conversation is not found' do
      post :show_group_chat, params: { group_conversation_id: "" }

      expect(response).to have_http_status(:not_found)

      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Group Conversation not found.')
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        name: 'Test Group',
        description: 'This is a test group.',
        icon: 'group_icon.png',
        user_ids: [user1.id, user2.id]
      }
    end
    let(:invalid_params) do
      {
        name: '',
        description: '',
        icon: '',
        user_ids: []
      }
    end

    context "when valid params" do 
      it 'creates a new group conversation successfully' do
        expect {
          post :create, params: valid_params
        }.to change(GroupConversation, :count).by(1)
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Group successfully Created')
      end
    end

    context "when Invalid params" do 
      it 'render a errror message' do
        
        expect {
          post :create, params: valid_params
        }.to change(GroupConversation, :count).by(1)
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Group successfully Created')
      end
    end
  end

  describe 'post #group_information' do
    context 'when group conversation exists' do
      it 'returns group conversation information' do
        post :group_information, params: { group_conversation_id: group_conversation1.id }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json_response['group_information']['id']).to eq(group_conversation1.id)
        expect(json_response['group_information']['name']).to eq(group_conversation1.name)
        expect(json_response['group_information']['icon']).to eq(group_conversation1.icon)
        expect(json_response['group_information']['description']).to eq(group_conversation1.description)
        expect(json_response['group_information']['users'].length).to eq(2)
        expect(json_response['group_information']['users'][0]['id']).to eq(group_conversation1.users.first.id)
        expect(json_response['group_information']['users'][0]['full_name']).to eq(group_conversation1.users.first.full_name)
        expect(json_response['group_information']['users'][1]['id']).to eq(group_conversation1.users.second.id)
        expect(json_response['group_information']['users'][1]['full_name']).to eq(group_conversation1.users.second.full_name)
      end
    end

    context 'when group conversation does not exist' do
      it 'returns not found error when group conversation is not found' do
        post :group_information, params: { group_conversation_id: 'invalid_id' }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(json_response['error']).to eq('Group Conversation with ID invalid_id not found.')
      end
    end
  end

  describe 'POST #add_member' do
    context 'when the user exists and is not a member of the group' do
      it 'adds the user as a member to the group conversation' do
        post :add_member, params: { group_conversation_id: group_conversation1.id, user_id: user1.id }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json_response['message']).to eq('User added to the group conversation successfully.')
      end
    end

    context 'when the user does not exist' do
      it 'returns not found error' do
        post :add_member, params: { group_conversation_id: group_conversation1.id, user_id: 'invalid_id' }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(json_response['error']).to eq('User with ID invalid_id not found.')
      end
    end

    context 'when the user is already a member of the group' do
      before { group_conversation1.users << user1 }

      it 'returns unprocessable entity error' do
        post :add_member, params: { group_conversation_id: group_conversation1.id, user_id: user1.id }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['error']).to eq('User is already a member of the group.')
      end
    end
  end

  describe 'GET #view_schedule' do
    it 'returns the user schedule for the group conversation' do

      post :view_schedule, params: { group_conversation_id: group_conversation1.id, user_id: user1.id }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)

      expect(json_response['view_schedule']['id']).to eq(user1.id)
      expect(json_response['view_schedule']['first_name']).to eq(user1.first_name)
      expect(json_response['view_schedule']['last_name']).to eq(user1.last_name)

      expect(json_response['view_schedule']['id']).to eq(booking.id)
      expect(json_response['view_schedule']['booking_date']).to eq(booking.booking_date.as_json)
      expect(json_response['view_schedule']['time_slot']).to eq(booking.time_slot)
    end

    it 'returns an error if the user is not found' do
      post :view_schedule, params: { group_conversation_id: group_conversation1.id, user_id: 9999 }

      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('User with ID 9999 not found.')
    end

    it 'returns an error if the group conversation is not found' do
      post :view_schedule, params: { group_conversation_id: "", user_id: user1.id }

      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Group Conversation with ID not found.')
    end
  end

  describe 'post #remove_member' do
    before { group_conversation1.users << user1 }

    context 'when the user is a member of the group' do
      it 'removes the user from the group conversation' do
        post :remove_member, params: { group_conversation_id: group_conversation1.id, user_id: user1.id }

        json_response = JSON.parse(response.body)
        group_conversation1.reload
        expect(response).to have_http_status(:ok)
        expect(json_response).to eq("message"=>"User successfully removed from the group conversation.")
        expect(group_conversation1.users).not_to include(user1)
      end
    end

    context 'when the user does not exist' do
      it 'returns not found error' do
        post :remove_member, params: { group_conversation_id: group_conversation1.id, user_id: 'invalid_id' }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(json_response['error']).to eq('User with ID invalid_id not found.')
      end
    end

    context 'when the user is not a member of the group' do
      let(:non_member_user) { FactoryBot.create(:user) }

      it 'returns unprocessable entity error' do
        post :remove_member, params: { group_conversation_id: group_conversation1.id, user_id: non_member_user.id }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['error']).to eq('User is not a member of the group.')
      end
    end
  end

  describe 'DELETE #delete_group' do
    context 'when the group conversation exists' do
      it 'deletes the group conversation' do
        delete :delete_group, params: { group_conversation_id: group_conversation1.id }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json_response['message']).to eq('Group conversation deleted successfully.')
      end
    end

    context 'when the group conversation does not exist' do
      it 'returns not found error' do
        delete :delete_group, params: { group_conversation_id: 'invalid_id' }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(json_response['error']).to eq('Group Conversation with ID  not found.')
      end
    end
  end
end