# frozen_string_literal: true

require 'application_system_test_case'
require 'test_helper'

class ReportsTest < ApplicationSystemTestCase
  include SystemTestAction

  setup do
    @alice = users(:alice)

    login_as @alice
    visit reports_url
  end

  test 'visiting the index' do
    assert_selector 'h1', text: Report.model_name.human
  end

  test 'creating a Report' do
    click_on I18n.t('views.common.new')

    title = '日報を作成'
    content = '日報を作成しました'
    fill_in_report_form title: title, content: content
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('controllers.common.notice_create', name: Report.model_name.human)
    assert_text_report_except_created_on title: title, content: content, user: @alice
    assert_text I18n.l(Report.last.created_on)
  end

  test 'failure to create a Report when title is blank' do
    click_on I18n.t('views.common.new')

    title = ''
    content = '日報を作成しました'
    fill_in_report_form title: title, content: content
    click_on I18n.t('helpers.submit.create')

    assert_text Report.human_attribute_name(:title) + I18n.t('errors.messages.blank')
  end

  test 'failure to create a Report when content is blank' do
    click_on I18n.t('views.common.new')

    title = '日報を作成'
    content = ''
    fill_in_report_form title: title, content: content
    click_on I18n.t('helpers.submit.create')

    assert_text Report.human_attribute_name(:content) + I18n.t('errors.messages.blank')
  end

  test 'updating a Report' do
    within 'tbody' do
      click_on I18n.t('views.common.edit'), match: :first
    end

    title = '日報を更新'
    content = '日報を更新しました'
    fill_in_report_form title: title, content: content
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('controllers.common.notice_update', name: Report.model_name.human)
    assert_text_report_except_created_on title: title, content: content, user: @alice
    assert_text I18n.l(Report.order(:updated_at).last.created_on)
  end

  test 'failure to update a Report when title is blank' do
    click_on I18n.t('views.common.edit')

    title = ''
    content = '日報を作成しました'
    fill_in_report_form title: title, content: content
    click_on I18n.t('helpers.submit.update')

    assert_text Report.human_attribute_name(:title) + I18n.t('errors.messages.blank')
  end

  test 'failure to update a Report when content is blank' do
    click_on I18n.t('views.common.edit')

    title = '日報を作成'
    content = ''
    fill_in_report_form title: title, content: content
    click_on I18n.t('helpers.submit.update')

    assert_text Report.human_attribute_name(:content) + I18n.t('errors.messages.blank')
  end

  test 'destroying a Report' do
    page.accept_confirm do
      click_on I18n.t('views.common.destroy'), match: :first
    end

    assert_text I18n.t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def fill_in_report_form(title:, content:)
    fill_in Report.human_attribute_name(:title), with: title
    fill_in Report.human_attribute_name(:content), with: content
  end

  def assert_text_report_except_created_on(title:, content:, user:)
    assert_text title
    assert_text content
    assert_text user.name
  end
end
