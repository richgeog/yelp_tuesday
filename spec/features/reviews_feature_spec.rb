require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end
end

#feature 'deleting reviews' do
 # before do
  #  Restaurant.create name: 'Pilpel'
   # restaurant = Restaurant.find(name: 'Pilpel')
    #restaurant.reviews(thoughts: 'It was yummy', rating: 4)
  #end

 # scenario 'deletes all dependencies of the restaurant' do
  #  visit '/restaurants'
   # click_link 'Delete Pilpel'
   # expect(page).not_to have_content 'Pilpel'
   # expect()
  #end
#end
