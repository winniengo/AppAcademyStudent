class TweetsController < ApplicationController
  before_action :require_login!

  def index
    @tweets = current_user.tweets
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)

    if @tweet.save
      redirect_to tweet_url(@tweet)
    else
      flash.now[:errors] = @tweet.errors.full_messages
      render :new
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])

    if @tweet.update(tweet_params)
      redirect_to tweet_url(@tweet)
    else
      flash.now[:errors] = @tweet.errors.full_messages
      render :edit
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :body)
  end
end
