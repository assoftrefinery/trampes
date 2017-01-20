class ProductTypesController < ApplicationController
  # GET /product_types
  # GET /product_types.json
  def index
    @product_types = ProductType.all.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_types }
    end
  end

  # GET /product_types/1
  # GET /product_types/1.json
  def show
    @product_type = ProductType.find(params[:id])

     respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_type }
    end
  end

  # GET /product_types/new
  # GET /product_types/new.json
  def new
    @product_type = ProductType.new

   # respond_to do |format|
   #   format.html # new.html.erb
   #   format.json { render json: @product_type }
   # end
  end

  # GET /product_types/1/edit
  def edit
    @product_type = ProductType.find(params[:id])
  end

  # POST /product_types
  # POST /product_types.json
  def create
    #@product_type = ProductType.new(params[:product_type])
    @product_type = ProductType.new(product_type_params)


    respond_to do |format|
      if @product_type.save
        format.html { redirect_to @product_type, :flash => { :success => "Tipus de Control creat amb exit" }}
        format.json { render json: @product_type, status: :created, location: @product_type }
      else
        format.html { render action: "new" }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_types/1
  # PUT /product_types/1.json
  def update
    @product_type = ProductType.find(params[:id])

    respond_to do |format|
      if @product_type.update_attributes(product_type_params)
        format.html { redirect_to @product_type, :flash => { :success => "Tipus de Control actualitzat" }}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_types/1
  # DELETE /product_types/1.json
  def destroy
    @product_type = ProductType.find(params[:id])
    @product_type.destroy

    respond_to do |format|
      format.html { redirect_to product_types_url, :flash => { :error => "Tipus de Control esborrat" }}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_type
      @product_type = ProductType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_type_params
      params.require(:product_type).permit(:name, :frecuencia, :dataproximcontrol, fields_attributes: [:id, :name, :field_type, :required, :llistat, :product_type_id, :_destroy])
      #params.require(:product_type).permit!
    end
end
