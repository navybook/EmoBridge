class Invitation < ApplicationRecord
  enum status: { pending: 0, accepted: 1 }

  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  validates :status, presence: true
  validate :sender_receiver_different
  validates :sender_id, uniqueness: { scope: %i[receiver_id status] }

  private

  def sender_receiver_different
    errors.add(:receiver_id, 'とsender_idは異なる必要があります') if sender_id == receiver_id
  end
end
