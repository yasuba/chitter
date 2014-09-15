require 'spec_helper'

feature "User signing up" do

	scenario "when being logged out" do
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content("Hello, maya@test.com")
		expect(User.first.email).to eq("maya@test.com")
	end

	def sign_up(email = "maya@test.com",
				password = "password")
		visit '/users/new'
		expect(page.status_code).to eq(200)
		fill_in :email, :with => email
		fill_in :password, :with => password
		click_button "Sign up"
	end

end