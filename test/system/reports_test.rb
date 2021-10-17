# frozen_string_literal: true

require 'application_system_test_case'
require_relative '../support/system_test_action'

class ReportsTest < ApplicationSystemTestCase
  include SystemTestAction

  setup do
    @alice = users(:alice)
    login_as @alice
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
  end

  test 'creating a Report' do
    visit reports_url
    travel_to Time.zone.local(2021, 10, 4, 12, 0, 0) do
      click_on '新規作成'

      fill_in 'タイトル', with: 'Railsの基本を学習'
      fill_in '内容', with: 'Railsガイドを読みました。'
      click_on '登録する'

      assert_selector 'p#notice', text: '日報が作成されました。'
      assert_text 'Railsの基本を学習'
      assert_text 'Railsガイドを読みました。'
      assert_text @alice.name
      assert_text '2021/10/04'
    end
  end

  test 'failure to create a Report when title is blank' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: ''
    fill_in '内容', with: 'Railsガイドを読みました。'
    click_on '登録する'

    assert_text 'タイトルを入力してください'
  end

  test 'failure to create a Report when content is blank' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'Railsの基本を学習'
    fill_in '内容', with: ''
    click_on '登録する'

    assert_text '内容を入力してください'
  end

  test 'updating a Report' do
    visit reports_url
    within 'tbody' do
      click_on '編集', match: :first
    end

    fill_in 'タイトル', with: 'Railsの基本を学習'
    fill_in '内容', with: 'Railsガイドを読みました。'
    click_on '更新する'

    assert_selector 'p#notice', text: '日報が更新されました。'
    assert_text 'Railsの基本を学習'
    assert_text 'Railsガイドを読みました。'
    assert_text @alice.name
    assert_text '2021/10/04' # reports.yml で作成日を固定
  end

  test 'failure to update a Report when title is blank' do
    visit reports_url
    within 'tbody' do
      click_on '編集', match: :first
    end

    fill_in 'タイトル', with: ''
    fill_in '内容', with: 'Railsガイドを読みました。'
    click_on '更新する'

    assert_text 'タイトルを入力してください'
  end

  test 'failure to update a Report when content is blank' do
    visit reports_url
    within 'tbody' do
      click_on '編集', match: :first
    end

    fill_in 'タイトル', with: 'Railsの基本を学習'
    fill_in '内容', with: ''
    click_on '更新する'

    assert_text '内容を入力してください'
  end

  test 'destroying a Report' do
    visit reports_url

    # reports.yml のログインユーザー(alice)の日報データ
    assert_text 'テストについての学習'
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_selector 'p#notice', text: '日報が削除されました。'
    assert_no_text 'テストについての学習'
  end
end
