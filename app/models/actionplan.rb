class Actionplan < ApplicationRecord
  validates :action, presence: true
  validates :study, presence: true
  validates :infosource, presence: true
  validates :status, presence: true

  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  
end
