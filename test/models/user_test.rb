# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'foobar2', password_confirmation: 'foobar2')
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid name format edges case' do
    invalid_names = [
      '   ',
      'a' * 51
    ]
    invalid_names.each do |name|
      @user.name = name
      assert_not @user.valid?
    end
  end

  test 'invalid email format edge cases' do
    invalid_addresses = [
      '',
      "#{'a' * 244}@example.com",
      'user@.com',
      '@example.com',
      'user@example.',
      'user@-example.com'
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'invalid with duplicate email' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'valid email addresses' do
    valid_addresses = [
      'user@example.com',
      'USER@foo.COM',
      'A_US-ER@foo.bar.org',
      'first.last@foo.jp',
      'alice+bob@baz.cn'
    ]
    valid_addresses.each do |valid_addresses|
      @user.email = valid_addresses
      assert @user.valid?, "#{valid_addresses.inspect} should be valid"
    end
  end

  test 'valid when email is saved as lower-case' do
    mixed_case_email = 'Foo@ExamPle.com'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'invalid without password' do
    @user.password = @user.password_confirmation = '      '
    assert_not @user.valid?
  end

  test 'invalid when password is shorter than 6 characters' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'invalid when password contains no digits' do
    @user.password = 'a' * 6
    assert_not @user.valid?
  end

  test 'invalid when password contains no letters' do
    @user.password = @user.password_confirmation = '1' * 6
    assert_not @user.valid?
  end

  test 'valid when password contains at least one letter and one digit' do
    @user.password = @user.password_confirmation = 'zzzz111'
    assert @user.valid?test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create(content: "Lorem ipsum")
    assert_difference "Micropost.count", -1 do
      @user.destroy
    end
  end
end
