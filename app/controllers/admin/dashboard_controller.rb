class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]

  def show
    @products = Product.all.order(quantity: :desc)
    @categories = Category.all.order(quantity: :desc)
  end
end
