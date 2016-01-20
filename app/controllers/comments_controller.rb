class CommentsController < InheritedResources::Base
  respond_to :json

  def create(options={}, &block)
    @comment = build_resource
    @comment.text = ActionController::Base.helpers.strip_tags(@comment.text)
    @comment.point = Point.find(params[:point_id])
    @comment.user = current_user
    #image = Paperclip.io_adapters.for(params[:picture])
    #image.original_filename = "something.gif"
    #@comment.picture = image
    @comment.save
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy if (current_user.id== comment.user_id)
    render json: {ok: true}
  end


  private

  def comment_params
    params.require(:comment).permit(:text,:picture)
  end
end

