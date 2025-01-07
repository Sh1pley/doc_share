require 'rails_helper'

RSpec.feature "Teacher Authentication", type: :feature do
  scenario "Teacher can sign up, sign in, and sign out" do
    # Teacher signs up
    visit new_teacher_registration_path
    fill_in "Email", with: "teacher@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    # Verify that teacher is signed in by checking for the Logout link
    expect(page).to have_button("Logout")

    # Teacher signs out
    click_button "Logout"

    # Verify that teacher is signed out
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end
end
