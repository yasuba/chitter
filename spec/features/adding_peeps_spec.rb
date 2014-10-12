require 'spec_helper'

feature "User adds a peep" do

	scenario 'when browsing the homepage' do
		expect(Peep.count).to eq(0)
		visit '/users/new'
		sign_up
		post_peep("A string of fewer than 140 characters")
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.content).to eq("A string of fewer than 140 characters")
	end

	scenario 'when peeping we should see the username' do
		visit '/users/new'
		sign_up
		post_peep("A string of fewer than 140 characters")
		expect(page).to have_content("fewer than 140 characters - yasuba")
	end

	def post_peep(content)
		within('#new-peep') do
			fill_in 'content', :with => content
			click_button 'Post'
		end
	end
end
