require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  describe "GET #dashboard" do
    let(:teacher) { create(:teacher) }
    let!(:old_document) { create(:document, teacher: teacher, created_at: 1.week.ago) }
    let!(:new_document) { create(:document, teacher: teacher, created_at: 1.day.ago) }

    before do
      sign_in teacher
      get :dashboard
    end

    it "assigns documents in descending order of creation" do
      expect(assigns(:documents)).to eq([ new_document, old_document ])
    end
  end
end
