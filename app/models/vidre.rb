class Vidre < ActiveRecord::Base
  belongs_to :auditv

  mount_uploader :foto, FotoUploader
  mount_uploader :fotobase, FotoUploader

  TIPUS = ["Cristal", "Plastico duro", "Buenas practicas higienicas", "Buenas practicas manejo", "Food Defense", "Estructural/Infraestructura"]
  UBICACIO = ["ZB", "EF", "A1", "A2","A3","A4","A5","B","C","D","ED"]
end
