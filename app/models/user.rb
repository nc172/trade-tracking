class User < ApplicationRecord
  has_many :imports, dependent: :destroy
  has_many :trades, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end