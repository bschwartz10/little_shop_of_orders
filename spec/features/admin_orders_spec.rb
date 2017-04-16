require 'rails_helper'

describe "When an admin visits the admin dashboard" do
  it "they can see a listing of all orders" do
    @admin = User.create(email: "penelope@penelope1.com", password: "boom", role: 1)
    category = Category.create(title: "cosmic", slug: "cosmic")
    @fly = category.powers.create!(title: "flying", description: "You will be able to fly!", price: 5, image_url: "http://www.pngall.com/wp-content/uploads/2017/03/Peter-Pan-Free-Download-PNG.png")
    order1 = Order.create!(status: "ordered", user_id: @admin.id )
    order2 = Order.create!(status: "ordered", user_id: @admin.id )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit admin_dashboard_path

    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_content("Order #1")
    expect(page).to have_content("Order #2")

  end
  it "they can see the count of each status of orders" do
    @admin = User.create(email: "penelope@penelope1.com", password: "boom", role: 1)
    category = Category.create(title: "cosmic", slug: "cosmic")
    @fly = category.powers.create!(title: "flying", description: "You will be able to fly!", price: 5, image_url: "http://www.pngall.com/wp-content/uploads/2017/03/Peter-Pan-Free-Download-PNG.png")
    order1 = Order.create!(status: "ordered", user_id: @admin.id )
    order2 = Order.create!(status: "paid", user_id: @admin.id )
    order3 = Order.create!(status: "cancelled", user_id: @admin.id )
    order4 = Order.create!(status: "completed", user_id: @admin.id )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit admin_dashboard_path


    expect(page).to have_content("Ordered Orders: 1")
    expect(page).to have_content("Paid Orders: 1")
    expect(page).to have_content("Cancelled Orders: 1")
    expect(page).to have_content("Completed Orders: 1")
  end

  it "each order is a link that leads to its show page" do
    @admin = User.create(email: "penelope@penelope1.com", password: "boom", role: 1)
    category = Category.create(title: "cosmic", slug: "cosmic")
    @fly = category.powers.create!(title: "flying", description: "You will be able to fly!", price: 5, image_url: "http://www.pngall.com/wp-content/uploads/2017/03/Peter-Pan-Free-Download-PNG.png")
    order1 = Order.create!(status: "ordered", user_id: @admin.id )


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit admin_dashboard_path

    click_on "Order ##{order1.id}"
    expect(current_path).to eq(order_path(order1))
  end

  it "order status link leads to a page that lists all orders with that status" do
    @admin = User.create(email: "penelope@penelope1.com", password: "boom", role: 1)
    category = Category.create(title: "cosmic", slug: "cosmic")
    @fly = category.powers.create!(title: "flying", description: "You will be able to fly!", price: 5, image_url: "http://www.pngall.com/wp-content/uploads/2017/03/Peter-Pan-Free-Download-PNG.png")
    order1 = Order.create!(status: "ordered", user_id: @admin.id )


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit admin_dashboard_path

    click_on "Ordered Orders"

    expect(page).to have_content(order1.id)
  end
end
