require 'spec_helper'

describe ShoppingCart do
  let(:shopping_cart) { FactoryBot.build :shopping_cart }
  subject { shopping_cart }

  it { should respond_to(:total) }

  it { should validate_presence_of :total}
  it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
  
  it { should have_many(:orders) }
  it { should have_many(:products).through(:orders) }
end
