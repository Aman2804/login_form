class User < ApplicationRecord
  validates :email,:password , confirmation:true
  validates :email_confirmation, presence: true, on: :create
  validates :password, presence: true

end
