class User < ActiveRecord::Base

  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates_length_of :password, :minimum => 8
  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end

end
