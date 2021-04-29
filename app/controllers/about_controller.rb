class AboutController < ApplicationController
  def index
    @category = Category.first()
  end
end
