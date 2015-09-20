class NewsController < InheritedResources::Base

  respond_to :json
  actions only: [:index]

  def index
    @news = News.all.reverse_order.limit 50
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

