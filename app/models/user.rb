# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  name                   :string
#  slug                   :string
#  role                   :integer          default("user")
#  auth_token             :string
#  provider               :string
#  uid                    :string
#  image                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  family_id              :integer
#  invitation_uuid        :string
#
class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  belongs_to :family

  validates_presence_of :name
  enum role: [:user, :owner, :admin]

  before_validation :init_family, on: :create
  before_create :on_before_create
  after_create :on_after_create

  def last_name
    return "" if name.blank?
    name.split(" ").length > 1 ? name.split(" ")[1] : ""
  end

  private

  def init_family
    if invitation_uuid.present?
      invitation = Invitation.find_by_uuid(invitation_uuid)
      self.family = invitation.family
    elsif name.present?
      self.family = Family.create(name: last_name.titleize)
    end
  end

  def on_before_create
    self.auth_token = SecureRandom.hex.to_s
  end

  def on_after_create
    UserMailer.welcome_email(self).deliver_later
  end
end
