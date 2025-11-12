require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path # getメソッドを使ってユーザー登録ページにアクセス
    assert_no_difference 'User.count' do # ユーザ数が変わらないかどうかを検証するテスト
      post users_path, params: { user: { name: '',
                                         email: 'user@invalid',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    # 送信に失敗したときにnewアクションが再描画されるか検証するテスト
    assert_template 'users/new'

    assert_select 'div#error_explanation' # エラーメッセージの要素が存在するか検証
    assert_select 'div.alert-danger' # エラーメッセージの要素が存在するか検証
  end



  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Example User',
                                         email: 'abc@example.com',
                                         password: 'password',
                                         password_confirmation: 'password' } }
    end
    follow_redirect!
    # assert_template 'users/show'
    # assert_not flash.empty?
    # assert is_logged_in?
  end
end