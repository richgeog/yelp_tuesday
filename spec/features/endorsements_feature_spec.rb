require 'rails_helper'

  feature 'endorsing reviews' do
    before(:each) do
      user = build(:user)
      sign_up(user)
      visit '/restaurants/new'
      fill_in 'Name', with: 'kfc'
      attach_file('restaurant[image]', 'spec/features/images/kfc.jpg')
      click_button 'Create Restaurant'
      click_link 'Review kfc'
      fill_in 'Thoughts', with: 'Nice'
      select '4', from: 'Rating'
      click_button 'Leave Review'
    end

  scenario 'a user can endorse a review, which updates the reviews endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 Endorsement')
  end
end

