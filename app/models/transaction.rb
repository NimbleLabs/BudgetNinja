# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  transaction_date :date
#  description      :string
#  amount           :decimal(, )
#  family_id        :bigint           not null
#  user_id          :bigint           not null
#  category_id      :bigint
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Transaction < ApplicationRecord
  extend FriendlyId
  friendly_id :transaction_label, use: [:slugged, :finders]

  belongs_to :family
  belongs_to :user
  belongs_to :category, optional: true
  before_validation :init_transaction_date, on: :create

  has_one_attached :receipt

  validates_presence_of :transaction_date
  # validates_presence_of :amount

  def init_transaction_date
    self.transaction_date = Date.today if transaction_date.blank?
  end

  def transaction_label
    "#{category.name} #{transaction_date}" if category.present?
    "#{transaction_date}"
  end
end
