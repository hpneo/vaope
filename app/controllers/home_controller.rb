class HomeController < ApplicationController

  def index
    @categories = Category.are_parents
  end

end