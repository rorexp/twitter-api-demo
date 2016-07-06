class UsersController < ApplicationController
  before_action :set_user

  def index
    @tweets =  @user.fetch_tweets
  end

  private
    def set_user
      @user = current_user
    end
end
