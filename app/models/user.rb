class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_initialize :set_defaults

  validates_presence_of :username

  private

  def set_defaults
    self.username ||= self.email.split("@").first
  end
end
