class CommentsController < InheritedResources::Base

  private

    def comment_params
      params.require(:comment).permit(:text)
    end
end

