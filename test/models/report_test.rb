# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @alice = users(:alice)
    @bob = users(:bob)
    @alice_report = reports(:alice_report)
  end

  test 'should #editable?(target_user) return true when #user equal target_user' do
    assert @alice_report.editable?(@alice)
  end

  test 'should #editable?(target_user) return false when #user differ from target_user' do
    assert_not @alice_report.editable?(@bob)
  end

  test 'should #created_on return Date object' do
    assert_instance_of(Date, @alice_report.created_on)
  end
end
