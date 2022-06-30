class Admin::DashboardController < ApplicationController
  def show
    @products = Product.all.order(quantity: :desc)
    @categories = Category.all.order(quantity: :desc)
  end
end
