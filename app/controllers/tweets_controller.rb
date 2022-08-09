class TweetsController < ApplicationController
  before_action :require_user_logged_in!

  def index
    @tweets = Current.user.tweets
  end

  def new
    @tweet = Tweet.new
  end

  def create 
    @tweet = Tweet.create(tweet_params)
    
    if @tweet.valid?
      @tweet.save
      session[:tweet_id] = @tweet.id
      retired_to tweets_path, notice: "Tweet was scheduled successfully"
    else
      render :new
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:twitter_account_id, :twitter_account, :body, :publish_at)
  end
end