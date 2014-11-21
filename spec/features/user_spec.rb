require 'spec_helper'

include SessionHelpers

feature "User signs in" do

  before(:each) do
    User.create(:name => "Maya",
          :username => "yasuba",
          :email => "maya@test.com",
          :password => 'test',
          :password_confirmation => 'test')
  end

  scenario "with correct credentials" do
    visit '/sessions/new'
    expect(page).not_to have_content("Hello, maya@test.com")
    sign_in("yasuba", 'test')
    expect(page).to have_content("Hello, yasuba")
  end

  scenario "with incorrect credentials" do
    visit '/sessions/new'
    expect(page).not_to have_content("Hello, yasuba")
    sign_in('yasuba', 'wrong')
    expect(page).not_to have_content("Hello, yasuba")
  end

end

feature "user signs out" do

  before(:each) do
    User.create(:username => "yasuba",
          :email => "test@test.com",
          :password => 'test',
          :password_confirmation => 'test')
  end

  scenario 'while being signed in' do
    visit '/sessions/new'
    sign_in('yasuba', 'test')
    click_button "Sign out"
    expect(page).to have_content("Good bye!")
    expect(page).not_to have_content("Welcome, yasuba")
  end

end

feature "User signing up" do

  scenario "when being registered" do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Hello, yasuba")
    expect(User.first.email).to eq("maya@test.com")
  end

  scenario "with a password that doesn't match" do
      expect{ sign_up('Maya', 'maya', 'mayaa@test.com', 'test', 'wrong') }.to change(User, :count).by(0)
      expect(current_path).to eq('/users')
      expect(page).to have_content("Sorry, your passwords don't match")
    end

    scenario "with an email that is already registered" do
      sign_up
      expect{ sign_up }.to change(User, :count).by(0)
      expect(page).to have_content("This email is already taken")
    end

end

