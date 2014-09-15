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

	def sign_in(email, password)
		visit '/sessions/new'
		fill_in 'email', :with => email
		fill_in 'password', :with => password
		click_button 'Sign in'
	end


end