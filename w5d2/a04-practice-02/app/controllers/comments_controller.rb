class CommentsController < ApplicationController
  before_action :require_login!

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id

    comment.save
    flash[:errors] = comment.errors.full_messages
    redirect_to link_url(params[:comment][:link_id])
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to link_url(comment.link_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :link_id)
  end
end
