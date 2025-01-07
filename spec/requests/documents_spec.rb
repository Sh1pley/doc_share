require 'rails_helper'

RSpec.describe "Documents", type: :request do
  let(:teacher) { create(:teacher) }

  before do
    login_as(teacher, scope: :teacher)
  end

  describe "POST /documents" do
    let(:file) { fixture_file_upload("spec/fixtures/files/test.md", "text/markdown") }

    it "creates a new MarkdownDocument" do
      post documents_path, params: { document: { title: "Test Doc", file: file } }
      expect(response).to redirect_to(authenticated_root_path)
      expect(MarkdownDocument.count).to eq(1)
    end
  end
end
