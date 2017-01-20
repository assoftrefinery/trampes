class Auditv < ActiveRecord::Base
  has_many :vidres,  dependent: :destroy
  accepts_nested_attributes_for :vidres
end
