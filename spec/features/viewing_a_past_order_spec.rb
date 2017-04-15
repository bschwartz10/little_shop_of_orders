require 'rails_helper'

RSpec.feature "User see past order" do
  before(:each) do
    @user = User.create(first_name: "v",
                       last_name: "v",
                       email: "pepe@pepe.com",
                       password: "password"
                       )
    category = Category.create(title: "cosmic", slug: "cosmic")
    @fly = category.powers.create!(title: "flying", description: "You will be able to fly!", price: 5, image_url: "http://www.pngall.com/wp-content/uploads/2017/03/Peter-Pan-Free-Download-PNG.png")
    @order = Order.create!(status: "Ordered", user_id: @user.id )
    @order_power = OrderPower.create(order_id: @order.id, power_id: @fly.id)
  end

  it "User can cancel order" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit order_path(@order)
    click_on "Cancel Order"
    expect(@order.status).to eq "Cancelled"
    expect(current_path).to eq powers_path
  end

  it "when user visits the order index page" do


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit orders_path
    expect(page).to have_link("Abilities Order ##{@order.id}")

    click_on "Abilities Order ##{@order.id}"
    # I should see each item that was order with the quantity and line-item subtotals
    expect(page).to have_link("flying Power")
    expect(page).to have_content("Ordered")
    expect(page).to have_content("5")
    expect(page).to have_content(@order.created_at)
    # If the order was completed or cancelled
    # then I should see a timestamp when the action took place
  end
end