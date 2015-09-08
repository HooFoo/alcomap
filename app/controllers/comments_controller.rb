class CommentsController < InheritedResources::Base
  respond_to :json

  def create(options={}, &block)
    @comment = build_resource
    @comment.point = Point.find(params[:point_id])
    @comment.user = current_user


    if create_resource(@comment)
      options[:location] ||= smart_resource_url
    end

    respond_with_dual_blocks(@comment, options, &block)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy if (current_user.id== comment.user_id)
    render json: {ok: true}
  end


  private

    def comment_params
      params.require(:comment).permit(:text)
    end
end

