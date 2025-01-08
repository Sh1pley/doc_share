require 'rails_helper'

RSpec.describe SlugGenerator do
  let(:model) { Document }

  describe '.generate' do
    it 'generates a unique slug for the given base/doc title' do
      base = "Test Document"

      expect(SlugGenerator.generate(base, model)).to match(/test-document/)
    end

    it 'appends a random string if the title/base already exists' do
      create(:document, title: "Test Document")
      base = "Test Document"

      expect(SlugGenerator.generate(base, model)).to match(/test-document-[\da-f]{8}/)
    end
  end
end
