require 'spec_helper'
require 'rails_helper'

RSpec.describe 'User Show:', type: :feature do
  before(:each) do
    visit new_user_session_path
    user = User.create!(name: 'Jonyole', email: 'john105908@gmail.com', confirmed_at: Time.now, password: 'password',
                        password_confirmation: 'password', bio: 'okay alright', photo: 'https://photo', posts_counter: 3, role: ' ')
    fill_in 'email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    5.times do |value|
      Post.create!(title: 'Real stressed', text: "Price#{value}", comments_counter: 4, likes_counter: 9,
                   user_id: user.id)
    end

    visit user_path(user.id)
  end

  it 'see the user name' do
    expect(page).to have_content('Jonyole')
  end

  it 'see the number of post' do
    expect(page).to have_content('Number of posts: 3')
  end

  it 'see the user bio' do
    expect(page).to have_content('okay alright')
  end

  it 'see the user all post' do
    expect(page).to have_button('See all')
  end

  it 'see the user profile picture' do
    visit page.find('#img')[:src]
    expect(page.status_code).to eq 200
  end

  it 'see the user three post' do
    expect(page).to have_content('Price4')
    expect(page).to have_content('Price3')
    expect(page).to have_content('Price2')
    expect(page).to have_no_content('Price1')
  end
end
