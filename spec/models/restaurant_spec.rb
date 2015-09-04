require 'rails_helper'
require 'spec_helper'

describe Restaurant, type: :model do

  context 'relationship with reviews' do
    it { is_expected.to have_many(:reviews).dependent(:restrict_with_exception) }
  end

  context 'relationship with user' do
    it { is_expected.to belong_to :user }
  end

  context 'validation' do
    it 'is not valid with a name of less than three characters' do
      restaurant = Restaurant.new(name: "kf")
      expect(restaurant).to have(1).error_on(:name)
      expect(restaurant).not_to be_valid
    end

    it 'is not valid unless it has a unique name' do
        Restaurant.create(name: "Moe's Tavern")
        restaurant = Restaurant.new(name: "Moe's Tavern")
        expect(restaurant).to have(1).error_on(:name)
    end
  end
end

describe 'reviews' do
  describe 'buil_with_user' do

    let(:user) { User.create email: 'test"test.com' }
    let(:restaurant) { Restaurant.create name: 'Test' }
    let(:review_params) { {rating: 5, thoughts: 'yum'} }

    subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

    it 'builds a review assoicaited with the specified user' do
      expect(review.user).to eq user
    end
  end
end
