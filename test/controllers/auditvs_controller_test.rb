require 'test_helper'

class AuditvsControllerTest < ActionController::TestCase
  setup do
    @auditv = auditvs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:auditvs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create auditv" do
    assert_difference('Auditv.count') do
      post :create, auditv: { dataaudit: @auditv.dataaudit, observacions: @auditv.observacions }
    end

    assert_redirected_to auditv_path(assigns(:auditv))
  end

  test "should show auditv" do
    get :show, id: @auditv
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @auditv
    assert_response :success
  end

  test "should update auditv" do
    patch :update, id: @auditv, auditv: { dataaudit: @auditv.dataaudit, observacions: @auditv.observacions }
    assert_redirected_to auditv_path(assigns(:auditv))
  end

  test "should destroy auditv" do
    assert_difference('Auditv.count', -1) do
      delete :destroy, id: @auditv
    end

    assert_redirected_to auditvs_path
  end
end
