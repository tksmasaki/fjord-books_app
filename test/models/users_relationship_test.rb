# frozen_string_literal: true

require 'test_helper'

class UsersRelationshipTest < ActiveSupport::TestCase
  def setup
    @one = users(:one)
    @two = users(:two)
    @users_relationship = UsersRelationship.new(follower_id: @one.id,
                                                following_id: @two.id)
  end

  test 'shoud be valid?' do
    assert @users_relationship.valid?
  end

  test 'should require a follower_id' do
    @users_relationship.follower_id = nil
    assert_not @users_relationship.valid?
  end

  test 'should require a following_id' do
    @users_relationship.following_id = nil
    assert_not @users_relationship.valid?
  end

  test 'should follow and unfollow a user' do
    assert_not @one.following? @two
    @one.follow @two
    assert @one.following? @two
    assert @two.followers.include? @one
    @one.unfollow @two
    assert_not @one.following? @two
  end

  test 'should destroy users_relationship when follower was destroyed' do
    @one.follow @two
    assert_not @two.followers.count.zero?
    @one.destroy
    assert @two.followers.count.zero?
  end

  test 'should destroy users_relationship when following user was destroyed' do
    @one.follow @two
    assert_not @one.followings.count.zero?
    @two.destroy
    assert @two.followings.count.zero?
  end
end
