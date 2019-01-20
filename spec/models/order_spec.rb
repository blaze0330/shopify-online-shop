require 'spec_helper'

describe Order do
  let(:order) { FactoryBot.build :order }
  subject { order }

  it { should respond_to :shopping_cart_id }
  it { should respond_to :product_id }

  it { should belong_to :shopping_cart }
  it { should belong_to :product }
end
