class Public::FavoritesController < ApplicationController
  
  def create
    shop = Shop.find(params[:shop_id])
    favorite = current_customer.favorites.new(shop_id: shop.id)
    favorite.save
    redirect_to(request.referer)
  end

  def destroy
    shop = Shop.find(params[:shop_id])
    favorite = current_customer.favorites.find(params[:id])
    favorite.destroy
    redirect_to(request.referer)
  end
  
  # def create
  #   @shop = Shop.find(params[:shop])
  #   current_user.favorite(@shop)
  # end

  # def destroy
  #   @shop = Favorite.find(params[:id]).shop
  #   current_user.unlike(@shop)
  # end
  
end


