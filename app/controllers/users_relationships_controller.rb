# frozen_string_literal: true

class UsersRelationshipsController < ApplicationController
  def create
    user = User.find(params[:following_id])
    current_user.follow user
    redirect_to user
  end

  def destroy
    user = UsersRelationship.find(params[:id]).following
    current_user.unfollow user
    redirect_to user
  end
end
