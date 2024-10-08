require "test_helper"

class CurrentHelperTest < ActionView::TestCase
  class LoggedInTest < ActionView::TestCase
    attr_reader :current_user

    setup do
      @current_user = users(:one)
      Current.user = @current_user
      Current.account = accounts(:one)
    end

    test "delegates to Current" do
      assert_not_nil Current.account
    end

    test "current_account_user" do
      assert_not_nil Current.account_user
    end

    test "current_account_admin? returns true for an admin" do
      account_user = account_users(:two)
      @current_user = account_user.user
      Current.user = account_user.user
      Current.account = account_user.account

      assert_equal account_user, Current.account_user
      assert Current.account_admin?
    end

    test "current_account_admin? returns false for a non admin" do
      account_user = account_users(:company_regular_user)
      @current_user = account_user.user
      Current.user = account_user.user
      Current.account = account_user.account

      assert_not Current.account_admin?
    end

    test "current account member is from current account" do
      account_user = Current.user.account_users.last
      Current.account = account_user.account
      assert_equal account_user, Current.account_user
    end

    test "current_roles" do
      Current.account = accounts(:company)
      assert_equal [:admin], Current.roles
    end
  end

  class LoggedOutTest < ActionView::TestCase
    setup do
      Current.reset
    end

    test "current_account should be nil" do
      assert_nil Current.account
    end

    test "current_account_user" do
      assert_nil Current.account_user
    end

    test "current_account_admin?" do
      assert_not Current.account_admin?
    end

    test "current_roles" do
      assert_empty Current.roles
    end
  end
end
