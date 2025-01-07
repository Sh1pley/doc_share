require 'rails_helper'

RSpec.describe "Teacher Dashboard", type: :feature do
  let(:teacher) { create(:teacher) }

  before do
    login_as(teacher, scope: :teacher)
  end

  it "displays a welcome message" do
    visit authenticated_root_path
    expect(page).to have_content("Welcome, #{teacher.email}")
  end

  it "allows the teacher to upload a document" do
    visit authenticated_root_path
    attach_file("document[file]", Rails.root.join("spec/fixtures/files/test.md"))
    fill_in "document[title]", with: "My Test Document"
    click_button "Upload"

    expect(page).to have_content("My Test Document")
    expect(Document.count).to eq(1)
  end
end
