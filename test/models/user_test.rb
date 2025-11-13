require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'password', password_confirmation: 'password')
  end
  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '   '
    assert_not @user.valid?
  end
  test 'email should be present' do
    @user.email = '   '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51 # 51文字の文字列を簡単に作るために文字列のかけ算
    assert_not @user.valid?
  end
  test 'email should not be too long' do
    @user.email = 'a' * 260 # 260文字の文字列を簡単に作るために文字列のかけ算
    assert_not @user.valid?
  end
  # ちゃんとemailか
  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # 一意性の検証　unique emailを複製して登録したら弾かれるか検証
  test 'email addresses should be unique' do
    duplicate_user = @user.dup # 今いるユーザー（@user）をコピーして、そっくりさんを作
    # duplicate_user.email = @user.email.upcase # 大文字小文字の区別をなくすためにupcaseメソッドで大文字に変換
    @user.save # 元のユーザーを保存
    assert_not duplicate_user.valid? # 登録しちゃダメだよね？
  end

  # メールアドレスを小文字にするテスト
  test 'email should be saved as downcase' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  #   なぜ reload が必要なの？@user.save でデータベースに保存したあと、Rubyの中の @user はまだ古い情報を持ってることがあるんです。
  # だから、データベースからもう一回読み直す必要があり
  # 
#パスワードがブランクじゃないよね？
test 'password should be present (nonblank)' do
  @user.password = @user.password_confirmation = ' ' * 6
  assert_not @user.valid?
end
#パスワード文字数OK？
  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
end
