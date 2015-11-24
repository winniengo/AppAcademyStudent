class RepliesController < ApplicationController
  before_action :require_login!

  def create
    @reply = Reply.new(reply_params)

    @reply.save
    flash[:errors] = @reply.errors.full_messages
    redirect_to tweet_url(params[:reply][:tweet_id])
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.delete
    redirect_to tweet_url(@reply.tweet_id)
  end

  private

  def reply_params
    params.require(:reply).permit(:body, :tweet_id)
  end
end
