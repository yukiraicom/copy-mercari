class PurchasesController < ApplicationController
  
  def new
    @item = Item.find(params[:id])
  end

  def create
    customer_id = current_user.card.customer_id
    charge = Payjp::Charge.create(
    amount: 3500,
    currency: 'jpy',
    customer: customer_id,
    )
    redirect_to "/products"
  end
end
