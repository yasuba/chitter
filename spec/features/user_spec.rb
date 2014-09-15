require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User signing up" do

	scenario "when being logged out" do
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content("Hello, maya@test.com")
		expect(User.first.email).to eq("maya@test.com")
	end

end

feature "User signs in" do

	before(:each) do
		User.create(:email => "test@test.com",
					:password => 'test')
	end

	scenario "with correct credentials" do
		visit '/'
		expect(page).not_to have_content("Hello, test@test.com")
		sign_in('test@test.com', 'test')
		expect(page).to have_content("Hello, test@test.com")
	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("Hello, test@test.com")
		sign_in('test@test.com', 'wrong')
		expect(page).not_to have_content("Hello, test@test.com")
	end

end

feature "user signs out" do

	before(:each) do
		User.create(:email => "test@test.com",
					:password => 'test')
	end

	scenario 'while being signed in' do
		sign_in('test@test.com', 'test')
		click_button "Sign out"
		expect(page).to have_content("Good bye!")
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end

