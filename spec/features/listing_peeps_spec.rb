require 'spec_helper'

feature "User browses the list of peeps" do

  before(:each) {
    Peep.create(:content => "A status update of fewer than 140 characters")
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Yo! This is chitter.")
  end

  scenario "when reading peeps on home page" do
  	visit '/'
  	expect(page).to have_content("A status update of fewer than 140 characters")
  end
end