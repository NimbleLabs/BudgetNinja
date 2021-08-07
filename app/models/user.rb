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
#  invitee_uuid           :string
#
class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  validates_presence_of :name
  enum role: [:user, :owner, :admin]
  before_create :on_before_create

  def last_name
    return "" if name.blank?
    name.split(" ").length > 1 ? name.split(" ")[1] : ""
  end

  def on_before_create
    self.auth_token = SecureRandom.hex.to_s
  end
end
