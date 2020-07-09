require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#index' do
    before { get :index }
    it '一覧が表示されること' do
      expect(response).to have_http_status(200)
    end
  end
  
  describe '#update' do
  end
  
end