class Trampa < ActiveRecord::Base
  belongs_to :audit

  mount_uploader :foto, FotoUploader
  mount_uploader :fotobase, FotoUploader

  TIPUS = ["Trampa de llum", "Trampa de feromones", "Trampa de rosegadors - Interior", "Trampa de rosegadors - Exterior"]
  UBICACIO = ["ZB", "EF", "A1", "A2","A3","A4","A5","B","C","D","ED"]

  #Exportacion CSV
  #product = lo que queremos exportar
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  #para Highcharts

  def self.total_on(date)
    where("date(created_at) = ?",date).sum(:recompte)
  end

end


