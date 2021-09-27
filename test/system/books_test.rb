# frozen_string_literal: true

require 'application_system_test_case'
require 'test_helper'

class BooksTest < ApplicationSystemTestCase
  include SystemTestAction

  setup do
    login_as users(:alice)
  end

  test 'visiting the index' do
    assert_selector 'h1', text: Book.model_name.human
  end

  test 'creating a Book' do
    click_on I18n.t('views.common.new')

    title = '本を作成'
    memo = '本を作成しました'
    author = 'Alice'
    picture = Rails.root.join('db/seeds/cherry-book.jpg')
    fill_in_book_form title: title, memo: memo, author: author, picture: picture
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('controllers.common.notice_create', name: Book.model_name.human)
    assert_text_book title: title, memo: memo, author: author
    assert_selector 'img[src$="cherry-book.jpg"]'
  end

  test 'updating a Book' do
    within 'tbody' do
      click_on I18n.t('views.common.edit'), match: :first
    end

    title = '本を更新'
    memo = '本を更新しました'
    author = 'Alice'
    picture = Rails.root.join('db/seeds/cherry-book.jpg')
    fill_in_book_form title: title, memo: memo, author: author, picture: picture
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('controllers.common.notice_update', name: Book.model_name.human)
    assert_text_book title: title, memo: memo, author: author
    assert_selector 'img[src$="cherry-book.jpg"]'
  end

  test 'destroying a Book' do
    page.accept_confirm do
      click_on I18n.t('views.common.destroy'), match: :first
    end

    assert_text I18n.t('controllers.common.notice_destroy', name: Book.model_name.human)
  end

  private

  def fill_in_book_form(title:, memo:, author:, picture:)
    fill_in Book.human_attribute_name(:title), with: title
    fill_in Book.human_attribute_name(:memo), with: memo
    fill_in Book.human_attribute_name(:author), with: author
    attach_file Book.human_attribute_name(:picture), picture
  end

  def assert_text_book(title:, memo:, author:)
    assert_text title
    assert_text memo
    assert_text author
  end
end
