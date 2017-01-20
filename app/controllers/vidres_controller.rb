class VidresController < ApplicationController
  before_action :set_vidre, only: [:show, :edit, :update, :destroy]

  # GET /vidres
  # GET /vidres.json
  def index
    @vidres = Vidre.where(:auditv_id=>nil).page(params[:page]).per(10)
  end

  # GET /vidres/1
  # GET /vidres/1.json
  def show
  end

  # GET /vidres/new
  def new
    @vidre = Vidre.new
  end

  # GET /vidres/1/edit
  def edit
    @vidre = Vidre.find(params[:id])
    if (@vidre.auditv_id == nil)
      @msg='Editar plantilla de Vidres/PD/BPH/BPM/FD/E-I'
    else
      @msg='Editar Vidre/PD/BPH/BPM/FD/E-I'
    end
  end

  # POST /vidres
  # POST /vidres.json
  def create
    @vidre = Vidre.new(vidre_params)

    respond_to do |format|
      if @vidre.save
        format.html { redirect_to @vidre, notice: 'Plantilla Vidres/PD/BPM/BPH/FD/E-I creada.' }
        format.json { render :show, status: :created, location: @vidre }
      else
        format.html { render :new }
        format.json { render json: @vidre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vidres/1
  # PATCH/PUT /vidres/1.json
  def update
    respond_to do |format|
      if @vidre.update(vidre_params)
        if (request.referer == edit_vidre_url) && (@vidre.auditv_id != nil)
          format.html { redirect_to auditv_path(@vidre.auditv_id) , notice: 'Plantilla Vidres/PD/BPH/BPM/FD/E-I actualitzada.' }
          format.json { render :show, status: :ok, location: @vidre }
        else
          format.html { redirect_to @vidre, notice: 'La plantilla ha estat actualitzada' }
        end
      else
        format.html { render :edit }
        format.json { render json: @vidre.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /vidres/1
  # DELETE /vidres/1.json
  def destroy
    @vidre.destroy
    respond_to do |format|
      format.html { redirect_to vidres_url, notice: 'Plantilla Vidres/PD/BPM/BPH/FD/E-I esborrada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vidre
      @vidre = Vidre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vidre_params
      params.require(:vidre).permit(:id, :nom, :tipus, :ubicacio, :descripcio, :fotobase, :recompte, :estat_ok, :observacions, :foto, :auditv_id)
    end
end
