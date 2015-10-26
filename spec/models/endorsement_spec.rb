require 'rails_helper'

RSpec.describe Endorsement, type: :model do
  it { is_expected.to belong_to :review }
end
