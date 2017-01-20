class AuditvsController < ApplicationController
  before_action :set_auditv, only: [:show, :edit, :update, :destroy]

  # GET /auditvs
  # GET /auditvs.json
  def index
    @auditvs = Auditv.all.page(params[:page]).per(10)
  end

  # GET /auditvs/1
  # GET /auditvs/1.json
  def show
  end

  # GET /auditvs/new
  def new
    @vidres = Vidre.where(:auditv_id=>nil)
    @auditv = Auditv.new
    @auditv.vidres << @vidres
  end

  # GET /auditvs/1/edit
  def edit
    @auditv = Auditv.find(params[:id])
    @vidres = Vidre.find_by_auditv_id(:id)
  end

  # POST /auditvs
  # POST /auditvs.json
  def create
    @auditv = Auditv.new(auditv_params)
    @vidres = Vidre.where(:auditv_id=>params[:id])
    @vidres.build

    respond_to do |format|
      if @auditv.save
        format.html { redirect_to @auditv, notice: 'Auditoria Vidres/BPH/BPM/FD realitzada.' }
        format.json { render :show, status: :created, location: @auditv }
      else
        format.html { render :new }
        format.json { render json: @auditv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auditvs/1
  # PATCH/PUT /auditvs/1.json
  def update
    respond_to do |format|
      #if @auditv.update(audit_params)
      if @auditv.update(cabecera_params)
        format.html { redirect_to @auditv, notice: 'Auditoria Vidres/BPH/BPM/FD actualitzada.' }
        format.json { render :show, status: :ok, location: @auditv }
      else
        format.html { render :edit }
        format.json { render json: @auditv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auditvs/1
  # DELETE /auditvs/1.json
  def destroy
    @auditv.destroy
    respond_to do |format|
      format.html { redirect_to auditvs_url, notice: 'Auditv was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auditv
      @auditv = Auditv.find(params[:id])
      @vidres = Vidre.where(:auditv_id=>params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  # Never trust parameters from the scary internet, only allow the white list through.
  def auditv_params
    params.require(:auditv).permit(:id, :dataaudit, :observacions, vidres_attributes: [:nom, :tipus, :recompte, :descripcio, :estat_ok, :observacions, :ubicacio, :foto, :fotobase])
  end
  #intento de editar solo cabecera, (con exito)
  def cabecera_params
    params.require(:auditv).permit(:id, :dataaudit, :observacions)
  end
end