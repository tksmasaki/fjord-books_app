# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @alice = users(:alice)
    @bob = users(:bob)
  end

  test '#following?(other) should return true when user is following other' do
    assert @alice.following?(@bob)
  end

  test '#following?(other) should return false when user is not following other' do
    assert_not @bob.following?(@alice)
  end

  test '#followed_by?(other) should return true when user is followed by other' do
    assert @bob.followed_by?(@alice)
  end

  test '#followed_by?(other) should return false when user is not followed by other' do
    assert_not @alice.followed_by?(@bob)
  end

  test 'can follow a user' do
    assert_not @bob.following?(@alice)
    @bob.follow @alice
    assert @bob.following?(@alice)
  end

  test 'can unfollow a user' do
    assert @alice.following?(@bob)
    @alice.unfollow @bob
    assert_not @alice.following?(@bob)
  end

  test '#name_or_email should return name when name is present' do
    assert @alice.name.present?
    assert_equal 'Alice', @alice.name_or_email
  end

  test '#name_or_email should return email when name is blank' do
    @alice.name = ''
    assert_equal 'alice@example.com', @alice.name_or_email
    @alice.name = ' '
    assert_equal 'alice@example.com', @alice.name_or_email
    @alice.name = nil
    assert_equal 'alice@example.com', @alice.name_or_email
  end
end
