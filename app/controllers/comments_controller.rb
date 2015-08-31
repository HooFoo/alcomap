class CommentsController < InheritedResources::Base

  def create(options={}, &block)
    @comment = build_resource
    @comment.point = Point.find(params[:point_id])
    @comment.user = current_user

    if create_resource(@comment)
      options[:location] ||= smart_resource_url
    end

    respond_with_dual_blocks(@comment, options, &block)
  end

  private

    def comment_params
      params.require(:comment).permit(:text)
    end
end

