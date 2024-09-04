require 'rails_helper'

RSpec.feature "Authentication", type: :feature, js: true do
    before do
    @user = FactoryBot.create(:user,
      email: "test@test.com",
      password: "password"
    )
    @new_user = FactoryBot.create(:user,
      username: Faker::Internet.username(specifier: 5..10),
      email: Faker::Internet.email,
      password: 'password')
  end

  scenario "Visitor signs up for a new account" do
    visit("/register")

    fill_in "username", with: @new_user.username
    fill_in "email", with: @new_user.email
    fill_in "password", with: @new_user.password
    click_button "Create an account"

    expect(page).to have_selector("#current-user")
  end

  scenario "Visitor perform login to existed account" do
    visit("/login")

    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "Login"

    expect(page).to have_selector("#current-user")
  end

  scenario "Logged in user perform sign out" do
    visit("/login")

    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "Login"

    click_button(id: 'radix-:r2:')
    find('#logout-btn').click

    expect(page).to have_link("Login")
  end
end
