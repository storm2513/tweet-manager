module TweetsHelper
  def tweet_path(tid)
    "https://twitter.com/#{current_user.nickname}/status/#{tid}"
  end
end
