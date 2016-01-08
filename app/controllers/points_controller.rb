class PointsController < InheritedResources::Base

  respond_to :json

  def create
    process_picture
    @point = Point.new point_params
    @point.user = current_user
    if @point.save!
      News.new(:user => current_user, :point => @point).save
    end
    render 'show'
  end

  def index(options={}, &block)
    bounds = params[:bounds]
    if bounds.nil?
      super
    else
      get_points
    end
  end

  def destroy
    @point = Point.find(params[:id])
    if @point.user == current_user
      super
    end
  end

  def rate
    user = current_user
    @point = Point.find(params[:id])
    rated_list = RatedPoint.where('user_id = :uid and point_id = :pid', {uid: user.id, pid: @point.id})
    if rated_list.length==0
      rated = RatedPoint.new :direction => params[:direction],
                             :user => user,
                             :point => @point
      if params[:direction]
        rating = 1
      else
        rating = -1
      end
      @point.rating+=rating
      @point.save
      rated.save
      if @point.rating <= -5
        @point.destroy
      end
    end
    render 'show'
  end

  def get_points
    bounds = params[:bounds]
    settings =  params[:settings]
    @points = []
    @points.concat Point.shops(bounds).to_a if settings[:shops]
    @points.concat Point.bars(bounds).to_a if settings[:bars]
    @points.concat Point.messages(bounds).to_a if settings[:messages]
    @points.concat Point.markers(bounds).to_a if settings[:markers]
    render 'index.json'
  end

  private

  def process_picture
    if params[:point] && params[:picture]
      puts params[:picture].inspect
      data = Т.new(Base64.decode64(params[:picture][:data]))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = params[:point][:picture][:filename]
      data.content_type = params[:point][:picture][:content_type]
      params[:point][:picture] = data
    end
  end
  
  def point_params
    params.require(:point).permit(:lng, :lat, :name, :description, :point_type, :isFulltime, :cardAccepted, :beer, :hard, :elite, :picture => [:data, :filename])
  end
end

