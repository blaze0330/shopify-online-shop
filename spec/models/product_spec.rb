require 'spec_helper'

describe Product do
  let(:product) { FactoryBot.build :product }
  subject { product }

  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:inventory_count) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :inventory_count }
  it { should validate_numericality_of(:inventory_count).is_greater_than_or_equal_to(0) }

  it { should have_many(:orders) }
  it { should have_many(:shopping_carts).through(:orders) }

end
