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
      let!(:user1) { create(:user, password: 'Password@123') }
      let!(:content1) { create(:content, user: user1) }
      let!(:content2) { create(:content, user: user1) }

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
  end

  context 'When User is logged in' do
    let!(:user) { FactoryBot.create(:user, password: 'Password@123') }
    let!(:valid_token) { JsonWebToken.encode(user_id: user.id, email: user.email) }
    let(:auth_headers) { { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{valid_token}" } }

    it_behaves_like :authorized_requests
  end

  context 'When User has not a valid token' do
    it_behaves_like :unauthorized_requests
  end
end
