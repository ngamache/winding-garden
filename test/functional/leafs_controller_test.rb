require 'test_helper'

class LeafsControllerTest < ActionController::TestCase
  setup do
    @leaf = leafs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leafs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create leaf" do
    assert_difference('Leaf.count') do
      post :create, leaf: { body: @leaf.body, title: @leaf.title }
    end

    assert_redirected_to leaf_path(assigns(:leaf))
  end

  test "should show leaf" do
    get :show, id: @leaf
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @leaf
    assert_response :success
  end

  test "should update leaf" do
    put :update, id: @leaf, leaf: { body: @leaf.body, title: @leaf.title }
    assert_redirected_to leaf_path(assigns(:leaf))
  end

  test "should destroy leaf" do
    assert_difference('Leaf.count', -1) do
      delete :destroy, id: @leaf
    end

    assert_redirected_to leafs_path
  end
end
