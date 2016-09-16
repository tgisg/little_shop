require 'rails_helper'

RSpec.feature "authenticated user security" do
  scenario "authenticated users cannot view another user's private data" do
      # As an authenticated user
      order_1 = Fabricate(:order)
      order_2 = Fabricate(:order)
      user = order_1.user

      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Login"
      # I cannot view another user's private data (current or past orders, etc)
      visit orders_path

      within ".table" do
        expect(page).to have_css("td", :text => order_1.id)
        expect(page).to_not have_css("td", :text => order_2.id)
      end
  end

  # scenario "authenticated users cannot view another user's private data" do
  #     # As an authenticated user
  #     order_1 = Fabricate(:order)
  #     order_2 = Fabricate(:order)
  #     user = order_1.user
  #
  #     visit login_path
  #     fill_in "Username", with: user.username
  #     fill_in "Password", with: user.password
  #     click_button "Login"
  #     # I cannot view the adminsitrator screens or use admin functionality
  #     visit orders_path
  #
  #     within ".table" do
  #       expect(page).to have_css("td", :text => order_1.id)
  #       expect(page).to_not have_css("td", :text => order_2.id)
  #     end
  # end


end
#
# I cannot make myself an admin
