# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @alice = users(:alice)
    @bob = users(:bob)
    @alice_report = reports(:alice_report)
  end

  test '#editable?(target_user) should return true when #user equals target_user' do
    assert @alice_report.editable?(@alice)
  end

  test '#editable?(target_user) should return false when #user differs from target_user' do
    assert_not @alice_report.editable?(@bob)
  end

  test '#created_on should return created_at converted to Date object' do
    assert_equal @alice_report.created_at.to_date, @alice_report.created_on
  end
end
