FactoryBot.define do
  factory :document do
    title { "Sample Document" }
    teacher

    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test.md'), 'text/markdown') }
  end
end
