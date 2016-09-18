require 'rails_helper'

RSpec.describe OrderCompiler, type: :model do

  it "can populate an item order" do
    current_user = Fabricate(:user)
    item = Fabricate(:item)
    cart_contents = { item.id.to_s => 1 }
    expect(Order.count).to eq(0)

    order_compiler = OrderCompiler.new(cart_contents, current_user)

    expect(Order.count).to eq(1)
    expect(order_compiler.create.first.item_id).to eq(item.id)
    expect(order_compiler.create.length).to eq(1)
    expect(order_compiler.order.user_id).to eq(current_user.id)
  end

  it "can handle one order with multiple items and quantities" do
    item1 = Fabricate(:item)
    item2 = Fabricate(:item)
    item3 = Fabricate(:item)
    cart = {  item1.id.to_s => 1,
              item2.id.to_s => 1,
              item3.id.to_s => 1 }

    item_orders = OrderCompiler.new(cart, Fabricate(:user)).create

    expect(item_orders.length).to eq(3)
    item_orders.each do |item_order|
      expect(item_order).to be_instance_of(ItemOrder)
    end
  end
end