class AuditsController < ApplicationController
  #http_basic_authenticate_with name: "joan", password: "tio", except: :index

  before_action :set_audit, only: [:show, :edit, :update, :destroy]

  # GET /audits
  # GET /audits.json
  def index
    #pre-kaminari
    #@audits = Audit.all
    #post-kaminari
    @audits = Audit.page(params[:page]).per(10)

    #exportacion a CSV
    #respond_to do |format|
    #  format.html
    #  format.csv { render text: @audits.to_csv }
    #end
    #exportacion CSV -fin
  end

  # GET /audits/1
  # GET /audits/1.json
  def show
    #@trampas = Trampa.where(:audit_id=>params[:id])

    #exportacion a CSV
    #@trampas = @audit.trampas
    #respond_to do |format|
    #  format.html
    #  format.csv { render text: @audits.to_csv }
    #end
    #exportacion CSV -fin
  end

  # GET /audits/new
  def new
    #@trampas = Trampa.where(:audit_id=>'1')
    @trampas = Trampa.where(:audit_id=>nil)
    @audit = Audit.new
    @audit.trampas << @trampas
    #@audit = Audit.new
    #@audit.trampas.build
  end

  # GET /audits/1/edit
  def edit
    #trampas = Trampa.all
    #la linea anterior estaba descomentada
    #@trampas = Trampa.where(:audit_id=>params[:id])
    @audit = Audit.find(params[:id])
    @trampas = Trampa.find_by_audit_id(:id)
  end

  # POST /audits
  # POST /audits.json
  def create
    @audit = Audit.new(audit_params)
    @trampas = Trampa.where(:audit_id=>params[:id])
    @trampas.build

    respond_to do |format|
      if @audit.save
        format.html { redirect_to @audit, notice: 'Auditoria realitzada.' }
        format.json { render :show, status: :created, location: @audit }
      else
        format.html { render :new }
        format.json { render json: @audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /audits/1
  # PATCH/PUT /audits/1.json
  def update
      respond_to do |format|
        #if @audit.update(audit_params)
        if @audit.update(cabecera_params)
          format.html { redirect_to @audit, notice: 'Auditoria actualitzada.' }
          format.json { render :show, status: :ok, location: @audit }
        else
          format.html { render :edit }
          format.json { render json: @audit.errors, status: :unprocessable_entity }
        end
      end
  end


  # DELETE /audits/1
  # DELETE /audits/1.json
  def destroy
    @audit.destroy
    respond_to do |format|
      format.html { redirect_to audits_url, notice: 'Auditoria esborrada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audit
      @audit = Audit.find(params[:id])
      @trampas = Trampa.where(:audit_id=>params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audit_params
     params.require(:audit).permit(:id, :dataaudit, :observacions, trampas_attributes: [:nom, :tipus, :recompte, :estat_ok, :observacions, :ubicacio, :foto, :fotobase])
    end
    #intento de editar solo cabecera
    def cabecera_params
      params.require(:audit).permit(:id, :dataaudit, :observacions)
    end
end