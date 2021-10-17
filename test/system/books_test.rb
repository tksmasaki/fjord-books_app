# frozen_string_literal: true

require 'application_system_test_case'
require_relative '../support/system_test_action'

class BooksTest < ApplicationSystemTestCase
  include SystemTestAction

  setup do
    login_as users(:alice)
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本'
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'チェリー本'
    fill_in 'メモ', with: 'プログラミング経験者のためのRuby入門書です。'
    fill_in '著者', with: '伊藤 淳一'
    attach_file '画像', Rails.root.join('db/seeds/cherry-book.jpg')
    click_on '登録する'

    assert_selector 'p#notice', text: '本が作成されました。'
    assert_text 'チェリー本'
    assert_text 'プログラミング経験者のためのRuby入門書です。'
    assert_text '伊藤 淳一'
    assert_selector 'img[src$="cherry-book.jpg"]'
  end

  test 'updating a Book' do
    visit books_url
    within 'tbody' do
      click_on '編集', match: :first
    end

    fill_in 'タイトル', with: 'チェリー本'
    fill_in 'メモ', with: 'プログラミング経験者のためのRuby入門書です。'
    fill_in '著者', with: '伊藤 淳一'
    attach_file '画像', Rails.root.join('db/seeds/cherry-book.jpg')
    click_on '更新する'

    assert_selector 'p#notice', text: '本が更新されました。'
    assert_text 'チェリー本'
    assert_text 'プログラミング経験者のためのRuby入門書です。'
    assert_text '伊藤 淳一'
    assert_selector 'img[src$="cherry-book.jpg"]'
  end

  test 'destroying a Book' do
    visit books_url

    index = find_book_index('Ruby超入門')
    within(all('tbody tr')[index]) do
      assert_text 'Ruby超入門'
      page.accept_confirm do
        click_on '削除'
      end
    end

    assert_selector 'p#notice', text: '本が削除されました。'
    assert_no_text 'Ruby超入門'
  end

  private

  def find_book_index(title)
    Book.order(id: :desc).find_index { |book| book.title == title }
  end
end
