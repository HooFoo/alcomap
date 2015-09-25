class NewsController < ApplicationController

  respond_to :json

  def index
    @news = News.all.reverse_order.limit 50
  end

  def my
    @news = News.where('user_id = ?',current_user.id).offset(params[:shift]).reverse_order.limit 50
    render 'index'
  end

  def latest
    puts params[:id]
    @news = News.where("id > ?", params[:id])
    render 'index'
  end

  private

  def news_params
    params.require(:news).permit(:user_id, :point_id)
  end
end

