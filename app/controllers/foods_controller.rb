class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @food = Food.order("RANDOM()").first
  end
end
