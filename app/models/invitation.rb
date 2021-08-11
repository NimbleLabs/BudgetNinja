# == Schema Information
#
# Table name: invitations
#
#  id         :bigint           not null, primary key
#  email      :string
#  uuid       :string
#  family_id  :bigint
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Invitation < ApplicationRecord
  extend FriendlyId
  friendly_id :uuid, use: [:slugged, :finders]

  belongs_to :family

  validates_presence_of :email, :family
  before_validation :generate_token, on: :create
  after_create :send_invitation_email

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create

  def send_invitation_email
    # UserMailer.invitee(self).deliver_later
  end

  def generate_token
    self.uuid = SecureRandom.hex.to_s
  end

end
