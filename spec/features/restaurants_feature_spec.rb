require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      user = build(:user)
      sign_up(user)
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
       expect(page).to have_link 'Add a restaurant'
    end
  end

    context 'restaurants have been added' do
      before do
        Restaurant.create(name: 'KFC')
      end

      scenario 'display restaurants' do
        visit '/restaurants'
        expect(page).to have_content('KFC')
        expect(page).not_to have_content('No restaurants yet')
      end
    end

    context 'creating restaurants' do
      scenario 'if not signed in then user unable to add a restaurant' do
        visit '/restaurants'
        expect(page).not_to have_link 'Add a restaurant'
      end

      scenario 'user must be logged in before creating restaurant' do
        user = build(:user)
        sign_up(user)
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'KFC'
        click_button 'Create Restaurant'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq '/restaurants'
      end

    end

    context 'viewing restaurants' do
      let!(:kfc){Restaurant.create(name:'KFC')}
      scenario 'lets a user view a restaurant' do
        visit '/restaurants'
        click_link 'KFC'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq "/restaurants/#{kfc.id}"
      end
    end

    context 'editing restaurants' do
      before(:each) do
        user = build(:user)
        sign_up(user)
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'KFC'
        click_button 'Create Restaurant'
      end

      scenario 'user can not edit a restaurant if they did not create it' do

        userina = build(:userina)
        visit '/'
        click_link 'Sign out'
        sign_in(userina)
        visit '/restaurants'
        expect(page).not_to have_link('Edit KFC')
      end

      scenario 'only the creator can edit a restaurant' do
        visit '/restaurants'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(current_path).to eq '/restaurants'
      end
    end

    context 'deletimg restaurants' do
      before(:each) do
        user = build(:user)
        sign_up(user)
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'KFC'
        click_button 'Create Restaurant'
      end

      scenario 'user can not deleta restaurant if they did not create it' do
        userina = build(:userina)
        visit '/'
        click_link 'Sign out'
        sign_in(userina)
        visit '/restaurants'
        expect(page).not_to have_link('Delete KFC')
      end

      scenario 'only a creator can delete a restaurant' do
        visit 'restaurants'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant deleted successfully'
      end
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        user = build(:user)
        sign_up(user)
        visit 'restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
end
