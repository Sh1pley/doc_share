RSpec.describe MarkdownDocument do
  describe "#render_html" do
    it "implements render method" do
      document = FactoryBot.build(:markdown_document)

      expect { document.render_html }.not_to raise_error
    end
  end
end
