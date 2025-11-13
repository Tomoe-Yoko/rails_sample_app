require 'test_helper'
class UsersSignup < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
end

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

  test 'valid signup information with account activation' do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Example User',
                                         email: 'user@example.com',
                                         password: 'password',
                                         password_confirmation: 'password' } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
end





class AccountActivationTest < UsersSignup
  def setup
    super
    post users_path, params: { user: { name: 'Example User',
                                       email: 'user@example.com',
                                       password: 'password',
                                       password_confirmation: 'password' } }
    @user = assigns(:user)
  end

  test 'should not be activated' do
    assert_not @user.activated?
  end

  test 'should not be able to log in before account activation' do
    log_in_as(@user)
    assert_not is_logged_in?
  end

  test 'should not be able to log in with invalid activation token' do
    get edit_account_activation_path('invalid token', email: @user.email)
    assert_not is_logged_in?
  end

  test 'should not be able to log in with invalid email' do
    get edit_account_activation_path(@user.activation_token, email: 'wrong')
    assert_not is_logged_in?
  end

  test 'should log in successfully with valid activation token and email' do
    get edit_account_activation_path(@user.activation_token, email: @user.email)
    assert @user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
