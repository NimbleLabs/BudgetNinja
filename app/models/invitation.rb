# == Schema Information
#
# Table name: invitations
#
#  id         :bigint           not null, primary key
#  email      :string
#  uuid       :string
#  family_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Invitation < ApplicationRecord

  belongs_to :family

  validates_presence_of :email, :family
  before_create :generate_token
  after_create :send_invitation_email

  validates_email_format_of :email, :message => 'is not a valid email address'

  def send_invitation_email
    # UserMailer.invitee(self).deliver_later
  end

  def generate_token
    begin
      self.uuid = SecureRandom.hex.to_s
    end while self.class.exists?(uuid: uuid)
  end

end
