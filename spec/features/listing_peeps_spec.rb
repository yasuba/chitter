require 'spec_helper'

feature "User browses the list of peeps" do

  before(:each) {
    user = User.create(:name => "Maya",
          :username => "yasuba",
          :email => "maya@test.com",
          :password => 'test',
          :password_confirmation => 'test')
    Peep.create(:content => "A status update of fewer than 140 characters", user: user)
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("This is Shitter.")
  end

  scenario "when reading peeps on home page" do
  	visit '/'
  	expect(page).to have_content("A status update of fewer than 140 characters")
  end

  scenario "when viewing all of a user's peeps" do
    user = User.create(:name => "Stephen",
          :username => "lonestar",
          :email => "stephen@test.com",
          :password => 'test',
          :password_confirmation => 'test')
    Peep.create(:content => "Tweet", user: user)
    visit '/'
    click_link('yasuba')
    expect(page).not_to have_content('Tweet - stephen@test.com')
    expect(page).to have_content('A status update of fewer than 140 characters - yasuba') 
  end
end
