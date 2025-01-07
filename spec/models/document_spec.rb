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
end
