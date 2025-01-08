require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:teacher) { FactoryBot.create(:teacher) }

  context "when a file is uploaded" do
    let(:document) { FactoryBot.build(:document, teacher: teacher, file: file) }

    context "when the file is a valid markdown file" do
      let(:file) { fixture_file_upload('spec/fixtures/files/test.md', 'text/markdown') }

      it "is valid" do
        expect(document).to be_valid
      end
    end

    context "when the file is an invalid file type" do
      let(:file) { fixture_file_upload('spec/fixtures/files/test.txt', 'text/plain') }

      it "is invalid" do
        expect(document).not_to be_valid
        expect(document.errors[:file]).to include("must be a valid file type. Valid types: text/markdown")
      end
    end
  end

  context "when no file is uploaded" do
    let(:document) { FactoryBot.build(:document, teacher: teacher, file: nil) }

    it "is invalid" do
      expect(document).not_to be_valid
      expect(document.errors[:file]).to include("can't be blank")
    end
  end

  context "Document base class does not implement render method" do
    let(:document) { FactoryBot.build(:document) }

    it "should raise" do
      expect { document.render_html }.to raise_error(NotImplementedError)
    end
  end

  describe '#shareable_url' do
    let(:document) { create(:document, teacher: teacher, title: "Test Document") }

    it 'creates a unique URL based on the document slug' do
      expect(document.shareable_url).to match(/^\/share\/[\w-]+$/)
    end

    it "does not generate the same URL for two different documents" do
      doc1 = create(:document, teacher: teacher, title: "First Document")
      doc2 = create(:document, teacher: teacher, title: "Second Document")

      expect(doc1.slug).not_to eq(doc2.slug)
    end

    it "does not generate the same URL when titles are same" do
      doc1 = create(:document, teacher: teacher, title: "First Document")
      doc2 = create(:document, teacher: teacher, title: "First Document")

      expect(doc1.slug).not_to eq(doc2.slug)
    end
  end
end
