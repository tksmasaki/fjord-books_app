# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @alice = users(:alice)
    @bob = users(:bob)
  end

  test 'should #following?(other) return true when user is following other' do
    assert @alice.following?(@bob)
  end

  test 'should #following?(other) return false when user is not following other' do
    assert_not @bob.following?(@alice)
  end

  test 'should #followed_by?(other) return true when user is followed by other' do
    assert @bob.followed_by?(@alice)
  end

  test 'should #followed_by?(other) return false when user is not followed by other' do
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

  test 'should #name_or_email return name when name is present' do
    assert @alice.name.present?
    assert_equal 'Alice', @alice.name_or_email
  end

  test 'should #name_or_email return email when name is blank' do
    ['', ' ', nil].each do |name|
      @alice.name = name
      assert_equal 'alice@example.com', @alice.name_or_email
    end
  end
end
