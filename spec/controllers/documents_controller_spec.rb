require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  render_views

  let(:teacher) { create(:teacher) }
  let(:file) { fixture_file_upload('spec/fixtures/files/test.md', 'text/markdown') }

  before :each do
    sign_in teacher
  end

  describe "POST #create" do
    context "when uploading a valid markdown file" do
      it "creates a new document and redirects to root" do
        expect {
          post :create, params: { document: { title: "Test Doc", file: file } }
        }.to change(Document, :count).by(1)

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Document uploaded successfully.")
      end

      it "responds with turbo stream if format is turbo_stream" do
        post :create, params: { document: { title: "Turbo Doc", file: file } }, format: :turbo_stream
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      end

      it "creates a new MarkdownDocument" do
        expect {
          post :create, params: { document: { title: 'My Markdown Document', file: file, teacher_id: teacher.id } }
        }.to change(Document, :count).by(1)

        expect(Document.last.file.content_type).to eq("text/markdown")
        expect(Document.last).to be_a(MarkdownDocument)
        expect(response).to redirect_to(root_path)
      end
    end

    context "when uploading an invalid file type" do
      let(:file) { fixture_file_upload('spec/fixtures/files/test.txt', 'text/plain') }

      it "renders :new with HTML format" do
        post :create, params: { document: { title: "" } }
        expect(response).to redirect_to(root_path)
      end

      it "renders turbo_stream response on failure" do
        post :create, params: { document: { title: "" } }, format: :turbo_stream
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      end

      it "does not create a new document" do
        expect {
          post :create, params: { document: { title: 'Invalid File', file: file, teacher_id: teacher.id } }
        }.not_to change(Document, :count)

        expect(response).to render_template(:new)
      end
    end

    context "when the title is missing" do
      it "does not save the document and renders the new template" do
        # Simulate the creation of a document with no title
        expect {
          post :create, params: { document: { file: file }, format: :turbo_stream }
        }.to_not change(Document, :count)

        expect(assigns(:document).errors[:title]).to include("can't be blank")

        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    let(:document) { create(:markdown_document, teacher: teacher) }
    it "assigns the requested document to @document" do
      get :show, params: { id: document.id }
      expect(assigns(:document)).to eq(document)
    end

    it "renders the :show template" do
      get :show, params: { id: document.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #share_document" do
    let(:document) { create(:markdown_document, teacher: teacher) }
    context "when slug is valid" do
      it "finds the document by slug and renders :show" do
        get :share_document, params: { slug: document.slug }
        expect(assigns(:document)).to eq(document)
        expect(response).to render_template(:show)
      end
    end

    context "when slug is invalid" do
      it "renders a 404 page" do
        get :share_document, params: { slug: "invalid-slug" }

        expect(response).to have_http_status(:not_found)
        expect(flash[:alert]).to eq("Sorry, the document you're looking for could not be found.")
        expect(response.body).to include("The page you were looking for doesn’t exist.")
      end
    end
  end
end
