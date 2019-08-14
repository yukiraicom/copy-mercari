class Api::ItemController < ApplicationController
  def index
    @sub_category = category_params
  end

  private
  def category_params
  Category.where(parent_id: params.permit(:selected_number).require(:selected_number))
  end
end

