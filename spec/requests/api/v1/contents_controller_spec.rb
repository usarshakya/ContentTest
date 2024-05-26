# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ContentsController, type: :request do
  shared_context :authorized_requests do
    describe 'POST /api/v1/contents' do
      context 'when valid attributes' do
        let!(:valid_params) { build(:content, title: 'title test') }

        it 'creates content' do
          send_post_request('/api/v1/contents', valid_params.to_json)
          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:created)
          expect(json_response['data']['attributes']['title']).to eq('title test')
        end
      end

      context 'when invalid attributes' do
        let(:invalid_params) { build(:content, title: nil) }

        it 'returns a 422 unprocessable entity status' do
          send_post_request('/api/v1/contents', invalid_params.to_json)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'GET /api/v1/content' do
      let!(:content1) { create(:content, user:) }
      let!(:content2) { create(:content, user:) }

      it 'returns a successful response' do
        send_get_request('/api/v1/content', {})
        expect(response).to have_http_status(:success)
      end

      it 'returns all contents' do
        send_get_request('/api/v1/content', {})
        json_response = JSON.parse(response.body)
        expect(json_response['data'].count).to eq(2)
      end
    end

    describe 'PUT /api/v1/contents/:id' do
      let!(:content) { create(:content, user:) }
      context 'when valid parameters and self content' do
        let(:valid_attributes) { { title: 'Title 1', body: 'Body 1' } }

        it 'allows to update self created content successfully' do
          send_put_request("/api/v1/contents/#{content.id}", valid_attributes)
          content.reload
          expect(response).to have_http_status(:ok)
          expect(content.title).to eq('Title 1')
          expect(content.body).to eq('Body 1')
        end
      end

      context 'when invalid parameters and self content' do
        let!(:content) { create(:content, user:) }
        let(:invalid_attributes) { { title: '' } }

        it 'returns a 422 unprocessable entity status' do
          send_put_request("/api/v1/contents/#{content.id}", invalid_attributes)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when valid parameters but not self content' do
        let!(:user1) { create(:user, password: 'Password@123') }
        let!(:content1) { create(:content, user: user1) }
        let(:valid_attributes) { { title: 'Title 1', body: 'Body 1' } }

        it 'returns 404 as content doesnt found' do
          send_put_request("/api/v1/contents/#{content1.id}", valid_attributes)
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe 'DELETE /api/v1/contents/:id' do
      let!(:content) { create(:content, user:) }
      context 'when self created content' do
        it 'allows to destroy content successfully' do
          send_delete_request("/api/v1/contents/#{content.id}", {})
          expect(response).to have_http_status(:ok)
          expect(Content.count).to eq(0)
        end
      end

      context 'when not self created content' do
        let!(:user1) { create(:user, password: 'Password@123') }
        let!(:content1) { create(:content, user: user1) }

        it 'returns 404 as content doesnt found' do
          send_delete_request("/api/v1/contents/#{content1.id}", {})
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  shared_context :unauthorized_requests do
    describe 'POST /api/v1/contents' do
      let(:valid_params) { build(:content) }

      it 'returns unauthorized error' do
        send_post_request('/api/v1/contents', valid_params.to_json, {})
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'GET /api/v1/content' do
      it 'returns unauthorized error' do
        send_get_request('/api/v1/content', {}, {})
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'PUT /api/v1/contents/:id' do
      let!(:user1) { create(:user, password: 'Password@123') }
      let!(:content) { create(:content, user: user1) }
      it 'returns unauthorized error' do
        send_put_request("/api/v1/contents/#{content.id}", {}, {})
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'DELETE /api/v1/contents/:id' do
      let!(:user1) { create(:user, password: 'Password@123') }
      let!(:content) { create(:content, user: user1) }
      it 'returns unauthorized error' do
        send_put_request("/api/v1/contents/#{content.id}", {}, {})
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'When User is logged in' do
    let!(:user) { create(:user, password: 'Password@123') }
    let!(:valid_token) { JsonWebToken.encode(user_id: user.id, email: user.email) }
    let(:auth_headers) { { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{valid_token}" } }

    it_behaves_like :authorized_requests
  end

  context 'When User has not a valid token' do
    it_behaves_like :unauthorized_requests
  end
end
