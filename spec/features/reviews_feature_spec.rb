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

    xscenario 'user can see the delete review link on thier reviews' do
      expect(page).to have_link 'Delete Review'
    end

    xscenario 'the person who left the review can delete it' do
      click_link 'Delete Review'
      expect(page).not_to have_content('so so')
    end

    xscenario 'other person is not able to delete the review' do
    end
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  scenario 'displays an average rating for all reviews' do
    user = build(:user)
    user2 = build(:userina)
    sign_up(user)
    leave_review('So so', '3')
    click_link 'Sign out'
    sign_up(user2)
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end
end
