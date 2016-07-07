class NewsController < ApplicationController

  respond_to :json

  def index
    @news = News.by_settings(current_user.setting.to_h)
                .select { |news| news.point.actual? }
  end

  def my
    @news = News.where('user_id = ?',current_user.id).offset(params[:shift]).reverse_order.limit 50
    render 'index'
  end

  def latest
    @news = News.where("id > ?", params[:id])
                .select do |news|
      news.point.actual?
    end
    render 'index'
  end

  private

  def news_params
    params.require(:news).permit(:user_id, :point_id)
  end
end

