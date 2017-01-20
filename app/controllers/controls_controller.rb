class ControlsController < ApplicationController
  before_action :set_control, only: [:show, :edit, :update, :destroy]

  #Disponible en to el controller
  #query que hacemos en muchos metodos (asignar_fabricaciones es especial)
    #duplicar_registro
    #planning
    #new
    #edit
  before_action :definir_fabricaciones #only: [:duplicar_registro, :planning, :new, :edit]

  helper_method :sort_column, :sort_direction

  # ----------------------------------------------------------------------------------------------------------------------
  def definir_fabricaciones
    #lista general de fabricaciones
    @fabs = Fabricacio.find_by_sql("select DISTINCT TOP 25 * from
                                    (
                                    select 'Arboreto' NomEmp, C.Codigo, C.Fecha, M.NombreFabricacion
                                    froM Gest02..FabricacioCAP C LEFT join Gest02..FabricacioCapMy M on C.Codigo = M.Codigo
                                    WHERE C.OrdenFabricacion = 1  AND Codproyecto <> 'CERRADA'
                                    UNION
                                    select 'Crisol' NomEmp, C.Codigo, C.Fecha, M.NombreFabricacion
                                    froM Gest31..FabricacioCAP C LEFT join Gest31..FabricacioCapMy M on C.Codigo = M.Codigo
                                    WHERE C.OrdenFabricacion = 1  AND Codproyecto <> 'CERRADA'
                                    ) A
                                    ORDER BY Fecha DESC")
  end
# ----------------------------------------------------------------------------------------------------------------------
  def numpaginas
    numpaginas = 50
  end
# ----------------------------------------------------------------------------------------------------------------------
  def mostrar_tabla_control
    @todos =  Control.where("product_type_id = ?", params[:product_type_id])

    logger.info params[:product_type_id]

    respond_to do |format|
      format.js { @todos }
    end
  end
# ----------------------------------------------------------------------------------------------------------------------
  #asignar fabricacion a cabecera control
  def asignar_fabricacion

    #Aqui no es necesario hacer una consulta, solo queremos la fabricacion
    #Por lo que devolvemos el mismo param[:id] que se envia al servidor
    #Hago la consulta para dejar espacio al futuro para mas consultas

    #Notar que SOLO SELECCIONAMOS UN CAMPO AQUI >> Codigo
#=begin
    @mifab = Fabricacio.find_by_sql("select DISTINCT TOP 25 * from
                                    (
                                    select C.Codigo
                                    froM Gest02..FabricacioCAP C LEFT join Gest02..FabricacioCapMy M on C.Codigo = M.Codigo
                                    WHERE C.OrdenFabricacion = 1 AND Codproyecto <> 'CERRADA' AND C.Codigo = '#{params[:id]}'
                                    UNION
                                    select C.Codigo
                                    froM Gest31..FabricacioCAP C LEFT join Gest31..FabricacioCapMy M on C.Codigo = M.Codigo
                                    WHERE C.OrdenFabricacion = 1  AND Codproyecto <> 'CERRADA' AND C.Codigo = '#{params[:id]}'
                                    ) A")
#=end
   #render :text => @mifab.first.Codigo

   #render plain: @mifab.first.Codigo

    #Codigo funciona porque esta incluido en las tablas de la BD
    #Funciona con Codigo, Fecha, NombreFabricacion,NomEmp
    @micodigo = @mifab.first.Codigo

    respond_to do |format|
      #format.js { @mifab }
      format.js { @micodigo }
      #format.js { params[:id] }
      #format.js { @mifab.first.Codigo }
      #format.js { params[:id] } <-------------- dejar esto si solo queremos el codigo fabricacion
    end

    #logger.info 'Resultado: ' + @mifab

  end
# ----------------------------------------------------------------------------------------------------------------------
  #duplica un registro, sin copiar la :id
  def duplicar_registro
    #buscamos el control
      @original = Control.find(params[:id])
    #lo duplicamos
      @control = @original.dup
    #solo queremos la cabecera, ponemos las propiedades a 0
      @control.properties = {}
    #ponemos fecha actual
      @control.datacontrol = Time.now
  end
# ----------------------------------------------------------------------------------------------------------------------
  def planning

    #nota: voy a cambiar todos los time.now a time.zone.now. CHECK it . Solo los 3 primeros estaban con time.zone.now
    #test
    @todos =  Control.where(:nom => 'ControlsTest')

    #hechos hoy
    @controls_avui = Control.where("created_at >= ?", Time.zone.now.beginning_of_day).page(params[:page]).per(numpaginas)

    #hechos con fecha antes que hoy
    @controls_anteriors = Control.where("created_at < ?", Time.zone.now.beginning_of_day).page(params[:page]).per(numpaginas)

    #Controles atrasados
    @controls_endarrerits = Control.where("dataproximcontrol < ?", Time.zone.now.beginning_of_day).page(params[:page]).per(numpaginas)

    #controles que toca hacer hoy (:dataproximcontrol)
    @controls_per_fer_avui = Control.where(:dataproximcontrol => Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).page(params[:page]).per(numpaginas)

    #controles que toca hacer la semana que viene (:dataproximcontrol)
    @controls_per_fer_setmana = Control.where(:dataproximcontrol => Time.zone.now.next_week..Time.zone.now.next_week.end_of_week).page(params[:page]).per(numpaginas)

    #controles que toca hacer esta semana
    @controls_per_fer_aquesta_setmana = Control.where(:dataproximcontrol => Time.zone.now..Time.zone.now.end_of_week).page(params[:page]).per(numpaginas)

    #controles que toca hacer el mes que viene (:dataproximcontrol)
    #@controls_per_fer_mes = Control.where(:dataproximcontrol => Time.now.next_month..Time.now.next_month.end_of_month).page(params[:page]).per(numpaginas)
    @controls_per_fer_mes = Control.where(:dataproximcontrol => Time.zone.now.next_month.beginning_of_month..Time.zone.now.next_month.end_of_month).page(params[:page]).per(numpaginas)

    #fabs = sql etc etc

    respond_to do |format|
      format.html
    end
  end
# ----------------------------------------------------------------------------------------------------------------------
  #exportacion CSV, mirar MODEL tambien
  def exportar

    #@datos es nil . mejor dicho. @controls es nil, arreglar
    @datos = @@busqueda

    respond_to do |format|
      format.html { redirect_to root_url }
      format.csv { send_data @datos.to_csv, :type => 'text/csv; charset=iso-8859-1; header=present', filename: "controls-#{Date.today}.csv" }
      #format.csv { render text: @datos.to_csv }
    end
  end
# ----------------------------------------------------------------------------------------------------------------------
  # GET /controls
  # GET /controls.json
  def index
    #original sin search
    #@controls = Control.all.page(params[:page]).per(50).order(sort_column + " " + sort_direction)

    #nota: @@busqueda en raras ocasiones da error 'not initialized', buscar y evitar

  #Listado con busqueda . search=textbox, datacon=datepicker, search_desplegable=desplegable
  if params[:search].present? and params[:datacon].present? and params[:search_desplegable].present?
      @controls = Control.nomoperari(params[:search]).datacon(params[:datacon]).nomcontrol(params[:search_desplegable]).order(sort_column + " " + sort_direction).page(params[:page]).per(numpaginas)
      @@busqueda = @controls
  elsif params[:search].present? and params[:datacon].present?
      @controls = Control.nomoperari(params[:search]).datacon(params[:datacon]).order(sort_column + " " + sort_direction).page(params[:page]).per(numpaginas)
      @@busqueda = @controls
  elsif params[:search].present? and params[:search_desplegable].present?
      @controls = Control.nomoperari(params[:search]).nomcontrol(params[:search_desplegable]).order(sort_column + " " + sort_direction).page(params[:page]).per(numpaginas)
      @@busqueda = @controls
  elsif params[:datacon].present? and params[:search_desplegable].present?
      @controls = Control.datacon(params[:datacon]).nomcontrol(params[:search_desplegable]).order(sort_column + " " + sort_direction).page(params[:page]).per(numpaginas)
      @@busqueda = @controls
  elsif params[:search].present?
      @controls = Control.nomoperari(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(numpaginas)
      @@busqueda = @controls
  elsif params[:datacon].present?
      @controls = Control.datacon(params[:datacon]).order(sort_column + " " + sort_direction).page(params[:page]).per(numpaginas)
      @@busqueda = @controls
  elsif params[:search_desplegable].present?
      @controls = Control.nomcontrol(params[:search_desplegable]).order(sort_column + " " + sort_direction).page(params[:page]).per(numpaginas)
      @@busqueda = @controls
  else
      @controls = Control.all.page(params[:page]).per(50).order(sort_column + " " + sort_direction)
      @@busqueda = @controls
  end#if

     if @@busqueda.nil?
       @@busqueda = @controls
     end

  end
# ----------------------------------------------------------------------------------------------------------------------
  # GET /controls/1
  # GET /controls/1.json
  def show
    @control = Control.find(params[:id])
    @nombre = ProductType.find_by_sql("SELECT name FROM product_types WHERE product_types.id = #{params[:id]}")
    @tipo = ProductField.find_by_sql("SELECT product_fields.field_type
            FROM controls JOIN product_types
            ON controls.product_type_id = product_types.id
            JOIN product_fields
            ON product_fields.product_type_id = product_types.id
            WHERE controls.id = #{params[:id]}")
  end
  #innecesario
  #def nombre_control
  #  @nombrec = ProductType.find_by_sql("SELECT name FROM product_types WHERE product_types.id = #{params[:product_type_id]}")
  #end
# ----------------------------------------------------------------------------------------------------------------------
  # GET /controls/new
  def new
    @control = Control.new(product_type_id: params[:product_type_id])
    @nombre = ProductType.find_by_sql("SELECT name FROM product_types WHERE product_types.id = #{params[:product_type_id]}")
    @frec = ProductType.find_by_sql("SELECT frecuencia from product_types WHERE product_types.id = #{params[:product_type_id]}")

    #@fabs = sql etc etc
  end
# ----------------------------------------------------------------------------------------------------------------------
  # GET /controls/1/edit
  def edit
    @control = Control.find(params[:id])
    @nombre = ProductType.find_by_sql("SELECT name FROM product_types WHERE product_types.id = #{params[:id]}")
    @frec = ProductType.find_by_sql("SELECT frecuencia from product_types WHERE product_types.id = #{params[:id]}")

  end
# ----------------------------------------------------------------------------------------------------------------------
  # POST /controls
  # POST /controls.json
  def create
    #@control = Control.new(params[:control])
    #@control = Control.new(product_type_id: params[:product_type_id])
    @control = Control.new(control_params)
    #--------------------------------------------------------------------
    #@control.frecuencia = params[:frecuencia]
    #@control.dataproximcontrol = params[:dataproximcontrol]
    #@control.frecuencia = 'Diaria'
=begin
    freq = params[:control][:frecuencia]
    case freq
      when freq == "Diaria"
        @control.dataproximcontrol = @control.datacontrol + 1.days
      when freq == "Setmanal"
        @control.dataproximcontrol = @control.datacontrol + 1.week
      when freq == "Mensual"
        #Cuenta 30 dias a partir de hoy. diferente a hacerlo todos los meses el mismo dia
        #@control.dataproximcontrol = @control.datacontrol + 30.days

        #Mostrar el primer dia del mes que viene
        #@control.dataproximcontrol = @control.datacontrol.at_beginning_of_month.next_month

        #Cuenta 30 dias a partir de hoy. diferente a hacerlo todos los meses el mismo dia
        #@control.dataproximcontrol = @control.datacontrol.advance(:days => +30)

        #Cuenta 30 dias a partir de hoy. Mismo dia, pero mes que viene
        @control.dataproximcontrol = @control.datacontrol + 1.month
      when freq == "Anual"
        @control.dataproximcontrol = @control.datacontrol + 1.year
    end
=end
    #--------------------------------------------------------------------
    respond_to do |format|
      if @control.save
        #format.html { redirect_to @control, notice: 'Control creat amb exit.' }
        format.html { redirect_to @control, :flash => { :success => "Control creat amb exit" }}
        format.json { render :show, status: :created, location: @control }
      else
        format.html { render :new }
        format.json { render json: @control.errors, status: :unprocessable_entity }
      end
    end
  end
# ----------------------------------------------------------------------------------------------------------------------
  # PATCH/PUT /controls/1
  # PATCH/PUT /controls/1.json
  def update
    @control = Control.find(params[:id])

    #Actualizamos automaticamente la frecuencia si cambia el Tipo de Control
    #Basta con entrar en un Control y actualizarlo sin tocar nada

    #Buscamos la frecuencia del Tipo de Control
    @frec = ProductType.find_by_sql("SELECT frecuencia from product_types WHERE product_types.id = #{@control.product_type_id}")

    #Actualizamos la frecuencia del Control para que tenga la misma que su Tipo de Control
    @frec.each do |frecuencia|
      params[:control][:frecuencia] = frecuencia.frecuencia
     # logger.info frecuencia.frecuencia
    end

     #Tomamos el valor 'Diario','Semanal','Etc...'
     tiempo = params[:control][:frecuencia]

    #Por diseño se establece que la fecha del proximo control se cuenta a partir de HOY-AHORA
    case tiempo
      when 'Diaria'
        #@control.dataproximcontrol = Time.now + 1.days
        fecha = Time.now + 1.days
        params[:control][:dataproximcontrol] = fecha.to_s
        #logger.info 'MiauDiario ' + ' ' + fecha.to_s
      when  'Setmanal'
        #@control.dataproximcontrol = Time.now + 1.week
        fecha = Time.now + 1.week
        params[:control][:dataproximcontrol] = fecha.to_s
        #logger.info 'MiauSetmanal ' + ' ' + fecha.to_s
      when 'Mensual'
        #Cuenta 30 dias a partir de hoy. Mismo dia, pero mes que viene
        #@control.dataproximcontrol = Time.now + 1.month
        fecha = Time.now + 1.month
        params[:control][:dataproximcontrol] = fecha.to_s
        #logger.info 'MiauMensual ' + ' ' + fecha.to_s
      when 'Anual'
        #@control.dataproximcontrol = Time.now + 1.year
        fecha = Time.now + 1.year
        params[:control][:dataproximcontrol] = fecha.to_s
        #logger.info 'MiauAnual ' + ' ' + fecha.to_s
    end

    #logger.info 'Hola, la frecuencia es:' + ' ' + tiempo
    #logger.info  params[:control][:dataproximcontrol]

    #--------------------------------------------------------------------
    if @control.update_attributes(control_params)
      #redirect_to @control, notice: 'Control actualitzat amb exit.'
      #añadido respond_to , pero sigue saliendo dos veces el puto mensaje :notice
      respond_to do |format|
        format.html { redirect_to @control, :flash => { :notice => "Control actualitzat amb exit" }}
      end
    else
      render action: "edit"
    end
  end
# ----------------------------------------------------------------------------------------------------------------------
  # DELETE /controls/1
  # DELETE /controls/1.json
  def destroy
    @control.destroy
    respond_to do |format|
      #format.html { redirect_to controls_url, notice: 'Control esborrat' }
      #format.html { redirect_to controls_url, :flash => { :error => "Control esborrat" }} --> cambiado el 11/11/2016
      format.html { redirect_to :back, :flash => { :error => "Control esborrat" }}
      format.json { head :no_content }
    end
  end
  #---- ESTO NO HACE FALTA, EN PRINCIPIO <-- A fecha 26 octubre no tengo ni idea porqué escribi esto
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_control
      @control = Control.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def control_params
      #params.require(:control).permit(:nom, :datacontrol, :operari, :product_type_id, properties_attributes: [:id, :name, :field_type, :required, :product_type_id])
      #params.require(:control).permit(:nom, :datacontrol, :operari, :product_type_id, :properties, fields_attributes: [:id, :name, :field_type, :required, :product_type_id])
      #params.permit(:nom, :datacontrol, :operari, :product_type_id, :properties)

      #Esta es la version definitiva

      #def control_params
      params.require(:control).permit(:nom, :datacontrol, :operari, :product_type_id, :frecuencia, :dataproximcontrol, :fabricacio).tap do |whitelisted|
        whitelisted[:properties] = params[:control][:properties]
      end
     # end

      #Esta parece la forma buena, peeeeero
      #params.require(:control).permit(:nom, :datacontrol, :operari, :product_type_id,:properties)

      #Permitir toito,
      #params.require(:control).permit!

    end

  #Configuracion por defecto de la direccion de ordenacion
  private
  def sort_column
    params[:sort] || "nom"
  end

  def sort_direction
    params[:direction] || "asc"
  end

end