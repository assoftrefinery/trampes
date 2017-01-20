require 'test_helper'

class VidresControllerTest < ActionController::TestCase
  setup do
    @vidre = vidres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vidres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vidre" do
    assert_difference('Vidre.count') do
      post :create, vidre: { auditv_id: @vidre.auditv_id, descripcio: @vidre.descripcio, estat_ok: @vidre.estat_ok, foto: @vidre.foto, fotobase: @vidre.fotobase, nom: @vidre.nom, observacions: @vidre.observacions, recompte: @vidre.recompte, tipus: @vidre.tipus, ubicacio: @vidre.ubicacio }
    end

    assert_redirected_to vidre_path(assigns(:vidre))
  end

  test "should show vidre" do
    get :show, id: @vidre
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vidre
    assert_response :success
  end

  test "should update vidre" do
    patch :update, id: @vidre, vidre: { auditv_id: @vidre.auditv_id, descripcio: @vidre.descripcio, estat_ok: @vidre.estat_ok, foto: @vidre.foto, fotobase: @vidre.fotobase, nom: @vidre.nom, observacions: @vidre.observacions, recompte: @vidre.recompte, tipus: @vidre.tipus, ubicacio: @vidre.ubicacio }
    assert_redirected_to vidre_path(assigns(:vidre))
  end

  test "should destroy vidre" do
    assert_difference('Vidre.count', -1) do
      delete :destroy, id: @vidre
    end

    assert_redirected_to vidres_path
  end
end
