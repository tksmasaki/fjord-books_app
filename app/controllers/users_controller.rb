# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.with_attached_avatar.order('users_relationships.id DESC').page(params[:page])
    @title = "#{@user.email} | #{t('views.common.followings')}"
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.with_attached_avatar.order('users_relationships.id DESC').page(params[:page])
    @title = "#{@user.email} | #{t('views.common.followers')}"
    render 'show_follow'
  end
end
