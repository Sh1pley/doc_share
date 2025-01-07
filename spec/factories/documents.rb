FactoryBot.define do
  factory :document do
    title { "Sample Document" }
    teacher

    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'sample.md'), 'text/markdown') }
  end
end
