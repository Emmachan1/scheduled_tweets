class TweetsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = Current.user.tweets
  end

  def new
    @tweet = Tweet.new
  end

  def create 
    @tweet = Tweet.create(tweet_params)
    @tweet.user = Current.user 
    if @tweet.valid?
      @tweet.save
      session[:tweet_id] = @tweet.id
      redirect_to tweets_path, notice: "Tweet was scheduled successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update 
    if @tweet.update(tweet_params)
      session[:tweet_id] = @tweet.id
      redirect_to tweets_path, notice: "Tweet was updated successfully"
    else
      render :new
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "Tweet was unscheduled successfully"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:twitter_account_id, :twitter_account, :body, :publish_at)
  end

  def set_tweet
    @tweet = Current.user.tweets.find(params[:id])
  end
end