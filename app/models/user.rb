class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # has_paper_trail
  # mount_uploader :image, ImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]



  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if user
      return user
    else
      registered_user = User.where(email: auth.uid + "@twitter.com").first
      if registered_user
        return registered_user
      else
        user = User.create(
                          provider: auth.provider,
                          uid: auth.uid,
                          email: auth.uid+"@twitter.com",
                          password: Devise.friendly_token[0,20],
                          access_token: auth.credentials.token,
                          access_token_secret: auth.credentials.secret
                          )
      end
    end
  end

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter['consumer_key']
      config.consumer_secret     = Rails.application.secrets.twitter['consumer_secret']
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end
  end

  def fetch_tweets
    twitter_client.user_timeline.select { |tweet| tweet if tweet.created_at.beginning_of_year } rescue []
  end

  def group_by_month
    monthwise_tweets = fetch_tweets.group_by { |tweet| tweet.created_at.month }
    result = []
    (1..12).to_a.each_with_index do |month, index|
      result[index] = monthwise_tweets[index + 1].try(:count) || 0
    end
    result
  end
end
