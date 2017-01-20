class Control < ActiveRecord::Base
  belongs_to :product_type
  serialize :properties, Hash

  #mount_uploader :foto, FotoUploader

  FRECUENCIA = ["Segons lot", "Diaria", "Setmanal", "Mensual", "Anual"]

  RESPONSABLE = ["LMF", "MRP", "JTB"]

  # ----------------------------------------------------------------------------------------------------------------
  #Exportacion a CSV

  def self.to_csv(options = {})

    #attributes = %w{id nom datacontrol operari properties}

    attributes = %w{id nom datacontrol operari}

    CSV.generate(options) do |csv|

      csv.add_row column_names

      all.each do |foo|
        #values = foo.attributes.values
        #values = (foo.properties.attributes.values)
        values = attributes.map{ |attr| foo.send(attr) }
        foo.properties.each do |name, value|
          if foo.properties.present?
              values += [name]
              values += [value]
          end
      end

      csv.add_row values

      end
    end
  end

=begin
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def users_to_csv(controls)
    CSV.generate do |csv|
      csv << ["Id", "nom"]
      controls.each do |user|
        csv << [control.id, control.nom ]
      end
    end
  end
=end
  # ----------------------------------------------------------------------------------------------------------------

  #SCOPES . Substituyen a self.searchX . USO : @var = Modelo.scope(algo) . Usar en controller
  #ej: @controls = Control.nomoperari(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(numpaginas) if params[:search].present?

  scope :nomcontrol, -> (nom) { where("nom like ?", "#{nom}%")}

  scope :nomoperari, -> (operari) { where("operari like ?", "%#{operari}%")}

  scope :datacon, -> (datacon) { where("datacontrol like ?", "%#{datacon}%")}

  #BUSQUEDAS. DEPRECATED EN FAVOR DE SCOPES.
=begin
                #Busqueda simple por caja de texto -----------------------------------------------------------------------------
                def self.search(search)
                  if search
                    where('nom LIKE ? OR datacontrol LIKE ? OR operari LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
                  else
                    #scoped     <--- deprecated en rails 4.1, poner where(nil)
                    where(nil)
                  end
                end

                #Busqueda simple por desplegable -------------------------------------------------------------------------------
                def self.search_desplegable(search_desplegable)
                  if search_desplegable
                    where('nom LIKE ?', "%#{search_desplegable}%")
                  else
                    #scoped     <--- deprecated en rails 4.1, poner where(nil)
                    where(nil)
                  end
                end

                #Busqueda combinada (nuevo  -------------------------------------------------------------------------------
                def self.search_combinado(search_desplegable)
                  if search_desplegable
                    where('nom LIKE ? OR datacontrol LIKE ? OR operari LIKE ?', "%#{search_desplegable}%", "%#{search_desplegable}%","%#{search_desplegable}%" )
                  else
                    #scoped     <--- deprecated en rails 4.1, poner where(nil)
                    where(nil)
                  end
                end

                #Busqueda simple por frecuencia, lista controles segun les toca o les ha pasado la fecha ------------------------
                #WIP, probablemente deadend (principios setiembre 2016)
                def self.search_frecuencia(search_frecuencia)
                  if search_frecuencia
                    where('frecuencia LIKE ? ', "%#{search_frecuencia}%")
                  else
                    #scoped     <--- deprecated en rails 4.1, poner where(nil)
                    where(nil)
                  end
                end
=end
  # ----------------------------------------------------------------------------------------------------------------

  validate :validate_properties

    def validate_properties
      product_type.fields.each do |field|
        if field.required? && properties[field.name].blank?
          errors.add field.name, "no pot estar buit"
        end
      end
    end

  # ----------------------------------------------------------------------------------------------------------------

end