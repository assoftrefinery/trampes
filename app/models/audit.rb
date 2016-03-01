class Audit < ActiveRecord::Base
	has_many :trampas,  dependent: :destroy
	accepts_nested_attributes_for :trampas

	#product = lo que queremos exportar
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |product|
				csv << product.attributes.values_at(*column_names)
			end
		end
	end


end
