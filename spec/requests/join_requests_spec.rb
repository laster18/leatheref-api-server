require 'rails_helper'

RSpec.describe 'JoinRequests', type: :request do
  let(:owner_user) { FactoryBot.create(:user, login_name: 'god') }
  let(:other_user) { FactoryBot.create(:user, login_name: 'shit') }
  let(:request_user) { FactoryBot.create(:user, login_name: 'requeskun') }
  let(:community) { FactoryBot.create(:community, owner: owner_user) }

  describe 'GET: /api/communities/:community_id/join_requests - リクエスト一覧取得' do
    let!(:join_request) {
      FactoryBot.create(:join_request,
                        user: request_user,
                        community: community)
    }

    describe 'ゲストユーザーとして' do
      it '401が返ってくること' do
        get community_join_requests_path(community)
        expect(response).to have_http_status '401'
      end
    end

    describe '認証済みのユーザーとして' do
      context 'コミュニティオーナーである時' do
        it 'リクエスト一覧を取得でき、200が返ってくること' do
          token = log_in_as(owner_user)
          get community_join_requests_path(community), headers: generate_login_header(token)
          expect(response).to have_http_status '200'
          expect(JSON.parse(response.body).length).to eq 1
        end
      end

      context 'コミュニティオーナーではない時' do
        it '403が返ってくること' do
          token = log_in_as(other_user)
          get community_join_requests_path(community), headers: generate_login_header(token)
          expect(response).to have_http_status '403'
        end
      end
    end
  end

  describe 'POST: /api/communities/:community_id/join_requests - リクエストの作成' do
    let(:owner_user) { FactoryBot.create(:user, login_name: 'god') }
    let(:not_member_user) { FactoryBot.create(:user, login_name: 'shit') }
    let!(:member_user) { FactoryBot.create(:user, login_name: 'requeskun') }
    let!(:approval_community) { FactoryBot.create(:community, :approval, owner: owner_user) }
    let!(:community_member) { CommunityMember.create(community_id: approval_community.id, member_id: member_user.id) }

    before do
      @request_params = { message: '承認よろ！' }
    end

    describe 'publicなコミュニティ' do
      let!(:public_community) { FactoryBot.create(:community, owner: owner_user) }

      it 'リクエストを作成出来ないこと' do
        token = log_in_as(not_member_user)
        expect {
          post community_join_requests_path(public_community), headers: generate_login_header(token), params: @request_params
        }.to_not change(JoinRequest, :count)
        expect(response).to have_http_status '400'
      end
    end

    describe 'approvalなコミュニティ' do
      context 'コミュニティのメンバーではないユーザーのとき' do
        it 'リクエストを作成出来ること' do
          token = log_in_as(not_member_user)
          expect {
            post community_join_requests_path(approval_community), headers: generate_login_header(token), params: @request_params
          }.to change(JoinRequest, :count).by(1)
          expect(response).to have_http_status '201'
        end
      end

      context 'コミュニティメンバーの場合' do
        it 'リクエストを作成出来ないこと' do
          token = log_in_as(member_user)
          expect {
            post community_join_requests_path(approval_community), headers: generate_login_header(token), params: @request_params
          }.to_not change(JoinRequest, :count)
          expect(response).to have_http_status '400'
        end
      end

      context 'コミュニティのオーナーの場合' do
        it 'リクエストを作成出来ないこと' do
          token = log_in_as(owner_user)
          expect {
            post community_join_requests_path(approval_community), headers: generate_login_header(token), params: @request_params
          }.to_not change(JoinRequest, :count)
          expect(response).to have_http_status '400'
        end
      end
    end
  end

  describe 'POST: /api/communities/:community_id/join_requests/:id/accept - 承認' do
    describe '認証済みのユーザー' do
      context 'コミュニティのオーナーであれば' do
        it '承認出来ること'
        it 'コミュニティに承認したメンバーが追加されていること'
      end

      context 'コミュニティのオーナーではない場合' do
        it '承認出来ないこと'
        it 'コミュニティにメンバーが追加されないこと'
      end
    end
  end

  describe 'POST: /api/communities/:community_id/join_requests/:id/reject - 拒否' do
    describe '認証済みのユーザー' do
      context 'コミュニティのオーナーであれば' do
        it '正常に拒否出来ること'
        it 'コミュニティにメンバーが追加されていないこと'
      end

      context 'コミュニティのオーナーではない場合' do
        it '403が返ってくること'
        it 'コミュニティにメンバーが追加されていないこと'
      end
    end
  end

  describe 'GET: /api/communities/:community_id/join_requests/:id - 詳細取得' do
    describe '認証済みのユーザー' do
      context 'コミュニティのオーナーであれば' do
        it '取得出来ること'
      end

      context 'コミュニティのオーナーではない場合' do
        it '取得出来ないこと'
      end
    end
  end
end
