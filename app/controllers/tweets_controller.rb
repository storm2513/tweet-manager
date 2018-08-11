class TweetsController < ApplicationController
  before_action :set_client, only: %i[create destroy], if: :current_user
  before_action :set_vars, if: :current_user

  def index; end

  def create
    @tweet.user_id = current_user.id
    image = nil
    image = File.new(params[:tweet][:image].tempfile) if params[:tweet][:image]
    if @tweet.valid?
      post_tweet(@tweet, image)
    else
      flash[:error] = 'Tweet is not valid!'
      render :index
    end
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])
    delete_tweet(@tweet)
    @tweet.destroy
    redirect_to root_path
  end

  private

  def tweet_params
    params.fetch(:tweet, {}).permit(:body)
  end

  def set_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET']
      config.access_token        = @current_user.token
      config.access_token_secret = @current_user.secret
    end
  end

  def set_vars
    @tweet = Tweet.new(tweet_params)
    @tweets = current_user.tweets.order(created_at: :desc)
  end

  def post_tweet(tweet, image)
    if image
      posted = @client.update_with_media(tweet.body, image)
      tweet.image = posted.media[0].media_url.to_s
    else
      posted = @client.update(tweet.body)
    end
    tweet.tid = posted.id
    tweet.save
    flash[:success] = 'Tweet was successfully published!'
    redirect_to root_path
  rescue StandardError
    flash[:error] = 'Error in posting tweet to Twitter'
    tweet.errors[:base] << 'Error in posting tweet to Twitter'
    render :index
  end

  def delete_tweet(tweet)
    @client.destroy_status(tweet.tid)
    flash[:notice] = 'Tweet was successfully deleted'
  rescue StandardError
    flash[:error] = "Couldn't delete tweet from Twitter"
  end
end
