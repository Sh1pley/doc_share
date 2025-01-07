require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  let(:teacher) { create(:teacher) }

  before :each do
    sign_in teacher
  end

  describe "POST #create" do
    context "when uploading a valid markdown file" do
      let(:file) { fixture_file_upload('spec/fixtures/files/test.md', 'text/markdown') }

      it "creates a new MarkdownDocument" do
        expect {
          post :create, params: { document: { title: 'My Markdown Document', file: file, teacher_id: teacher.id } }
        }.to change(Document, :count).by(1)

        expect(Document.last.file.content_type).to eq("text/markdown")
        expect(MarkdownDocument.count).to eq(1)
        expect(response).to redirect_to(root_path)
      end
    end

    context "when uploading an invalid file type" do
      let(:file) { fixture_file_upload('spec/fixtures/files/test.txt', 'text/plain') }

      it "does not create a new document" do
        expect {
          post :create, params: { document: { title: 'Invalid File', file: file, teacher_id: teacher.id } }
        }.not_to change(Document, :count)

        expect(response).to render_template(:new)
      end
    end
  end
end
