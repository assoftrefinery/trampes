require 'test_helper'

class TrampasControllerTest < ActionController::TestCase
  setup do
    @trampa = trampas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trampas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trampa" do
    assert_difference('Trampa.count') do
      post :create, trampa: { audit_id: @trampa.audit_id, estat_ok: @trampa.estat_ok, nom: @trampa.nom, recompte: @trampa.recompte, tipus: @trampa.tipus }
    end

    assert_redirected_to trampa_path(assigns(:trampa))
  end

  test "should show trampa" do
    get :show, id: @trampa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trampa
    assert_response :success
  end

  test "should update trampa" do
    patch :update, id: @trampa, trampa: { audit_id: @trampa.audit_id, estat_ok: @trampa.estat_ok, nom: @trampa.nom, recompte: @trampa.recompte, tipus: @trampa.tipus }
    assert_redirected_to trampa_path(assigns(:trampa))
  end

  test "should destroy trampa" do
    assert_difference('Trampa.count', -1) do
      delete :destroy, id: @trampa
    end

    assert_redirected_to trampas_path
  end
end
