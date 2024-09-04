require 'rails_helper'

RSpec.feature "Dashboard", type: :feature, js: true do
  before do
    @user = FactoryBot.create(:user,
      email: "test@test.com",
      password: "password"
    )
    @video = FactoryBot.create(:video,
      url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    )
  end
  describe "unauthorized" do
    scenario "visitor can view all videos" do
      visit("/")
      expect(page).to have_selector(id: /^dashboard-chunk-/)
    end
  end

  describe "authorized" do
    before(:each) do
      visit("/login")
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Login'

      sleep(1)
    end

    scenario "user can view all videos" do
      visit("/")
      expect(page).to have_selector(id: /^dashboard-chunk-/)
    end

    scenario "user can see button Share new video" do
      visit("/")
      expect(page).to have_button("Share new video")
    end

    scenario "user can share video" do
      visit("/")
      click_button("Share new video")

      fill_in "url", with: @video.url
      click_button "Share"

      sleep(1)
      expect(page).to have_selector(id: /^dashboard-chunk-/)
      elements = all(:css, "[id^='dashboard-chunk-']")
      expect(elements.first).to have_content("Rick Astley - Never Gonna Give You Up (Official Music Video)")
    end
  end
end
