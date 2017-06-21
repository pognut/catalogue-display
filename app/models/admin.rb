class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :authentication_keys => [:username]
         include DeviseInvitable::Inviter
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
