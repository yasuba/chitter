module SessionHelpers

	def sign_up(name = "Maya",
				username = "yasuba",
				email = "maya@test.com",
				password = "password",
				password_confirmation = "password")
		visit '/users/new'
		# expect(page.status_code).to eq(200)
		fill_in :name, :with => name
		fill_in :username, :with => username
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Sign up"
	end

	def sign_in(username, password)
		visit '/sessions/new'
		fill_in 'username', :with => username
		fill_in 'password', :with => password
		# fill_in 'password confirmation', :with => password_confirmation
		click_button 'Sign in'
	end

end