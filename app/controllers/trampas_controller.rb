class TrampasController < ApplicationController
  before_action :set_trampa, only: [:show, :edit, :update, :destroy]

  # GET /trampas
  # GET /trampas.json
  def index
    #@trampas = Trampa.all
    #Mostrar solo las trampas sin audit_id, que son las plantillas
    #Si tienen audit_id quiere decir que forman parte de una Auditoria
    @trampas = Trampa.where(:audit_id=>nil)
  end

  # GET /trampas/1
  # GET /trampas/1.json
  def show
    #@trampa = Trampa.find(params[:id])
  end

  # GET /trampas/new
  def new
    @trampa = Trampa.new
  end

  # GET /trampas/1/edit
  def edit
    #render :text => 'HOLA'
    #@audit = Audit.where(:id=>params[:audits_id])
    #@trampa = Trampa.find(params[:id])
    #@audit = Audit.find(params[@trampa.audit_id])
    #session[:return_to] ||= request.referer
  end

  # POST /trampas
  # POST /trampas.json
  def create
    @trampa = Trampa.new(trampa_params)

    respond_to do |format|
      if @trampa.save
        format.html { redirect_to @trampa, notice: 'Plantilla creada amb exit.' }
        format.json { render :show, status: :created, location: @trampa }
      else
        format.html { render :new }
        format.json { render json: @trampa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trampas/1
  # PATCH/PUT /trampas/1.json
  def update
    respond_to do |format|
      if @trampa.update(trampa_params)
            if (request.referer == edit_trampa_url) && (@trampa.audit_id != nil)
              format.html { redirect_to audit_path(@trampa.audit_id) , notice: 'Trampa actualitzada.' }
              format.json { render :show, status: :ok, location: @trampa }
            else
              format.html { redirect_to @trampa, notice: 'La plantilla ha estat actualitzada' }
            end
      else
        format.html { render :edit }
        format.json { render json: @trampa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trampas/1
  # DELETE /trampas/1.json
  def destroy
    @trampa.destroy
    respond_to do |format|
      format.html { redirect_to trampas_url, notice: 'Plantilla esborrada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trampa
      @trampa = Trampa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trampa_params
      params.require(:trampa).permit(:id, :nom, :tipus, :recompte, :estat_ok, :observacions, :ubicacio, :foto, :audit_id)
    end
end
