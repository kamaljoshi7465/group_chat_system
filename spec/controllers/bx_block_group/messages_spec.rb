require "rails_helper"

RSpec.describe BxBlockGroup::MessagesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  describe "POST#create" do 
  let!(:group_conversation) { FactoryBot.create(:group_conversation)}
    context "when Group_conversation is present" do
      context "when valid params" do
        it "render a successfully create a message" do 
          post :create, params: { group_conversation_id: group_conversation.id, user_id: user.id, body: "hello guys!" }

          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:created)
          expect(json_response["message"]["body"]).to eq("hello guys!")
        end
      end
      context "when invalid params" do
        it "render a error" do 
          post :create, params: { group_conversation_id: group_conversation.id, user_id: user.id, body: "" }

          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response['error']).to eq("Validation failed: Body can't be blank")
        end
      end
    end
    context "when Group_conversation is not found" do
      it 'renders not found error' do
        post :create, params: { group_conversation_id: 'invalid_id', body: 'hello guys!' }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(json_response['error']).to eq('Group Conversation with ID invalid_id not found.')
      end
    end
  end
end