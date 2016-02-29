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
  describe 'build_with_user' do
    let(:user) { User.create email: 'test"test.com' }
    let(:restaurant) { Restaurant.create name: 'Test' }
    let(:review_params) { { rating: 5, thoughts: 'yum' } }
    subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

    it 'builds a review assoicaited with the specified user' do
      expect(review.user).to eq user
    end

    describe '#average_rating' do
      context 'no reviews' do
        it 'returns "N/A" when there are no reviews' do
          restaurant = Restaurant.create(name: 'The Ivy')
          expect(restaurant.average_rating).to eq 'N/A'
        end
      end

      context '1 review' do
        it 'returns that rating' do
          restaurant = Restaurant.create(name: 'The Ivy')
          restaurant.reviews.create(rating: 4)
          expect(restaurant.average_rating).to eq 4
        end
      end

      context 'multiple reviews' do
        it 'returns the average' do
          user = create(:user)
          user2 = create(:user, email: 'another@mail.com')
          restaurant = Restaurant.create(name: 'The Ivy')
          restaurant.reviews.create(rating: 1, user: user)
          restaurant.reviews.create(rating: 5, user: user2)
          expect(restaurant.average_rating).to eq 3
        end
      end
    end
  end
end
