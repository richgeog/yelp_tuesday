require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    user = build(:user)
    sign_up(user)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  context 'deleting reviews' do
    before(:each) do
      user = build(:user)
      sign_up(user)
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
    end

    scenario 'user can see the delete review link on thier reviews' do
      expect(page).to have_link 'Delete Review'
    end

    xscenario 'the person who left the review can delete it' do
      click_link 'Delete Review'
      expect(page).not_to have_content('so so')
    end

    scenario 'other person is not able to delete the review' do
    end
  end
end


