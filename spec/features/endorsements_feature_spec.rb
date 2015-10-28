require 'rails_helper'

  feature 'endorsing reviews' do
#   before do
#     kfc = Restaurant.create(name: 'KFC')
#     kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
#   end

  scenario 'a user can endorse a review, which updates the reviews endorsement count', js: true do
    user = build(:user)
    sign_up(user)
    visit '/restaurants/new'
    # click_link 'Add a restaurant'
    fill_in 'Name', with: 'kfc'
    attach_file('restaurant[image]', 'spec/features/images/kfc.jpg')
    click_button 'Create Restaurant'
    expect(page).to have_content 'kfc.jpg'
    expect(current_path).to eq '/restaurants'
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 Endorsement')
  end
end
