class Fabricacio < ActiveRecord::Base
  establish_connection :development_sql
  self.table_name = 'FabricacioCAP'

  #esto no funciona. probable causa: no existen los campos, porque es una consulta on-the-fly
  def fabtotal
    "#{'Codigo'} #{'NombreFabricacion'}"
  end

end