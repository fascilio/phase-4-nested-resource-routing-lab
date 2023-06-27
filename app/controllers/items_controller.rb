# class ItemsController < ApplicationController

#   def index
#     items = Item.all
#     render json: items, include: :user
#   end

# end
class ItemsController < ApplicationController
  before_action :set_user

  def index
    items = @user.items
    render json: items.as_json(only: [:id, :name, :description, :price, :user_id])
  end

  def show
    item = @user.items.find(params[:id])
    render json: item.as_json(only: [:id, :name, :description, :price, :user_id])
  end

  def create
    item = @user.items.build(item_params)
    if item.save
      render json: item.as_json(only: [:id, :name, :description, :price, :user_id]), status: :created
    else
      render json: { error: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end
