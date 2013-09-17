class Task < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  validates :title, :body, :complete_by, :team_id, presence: true
  validate :complete_by_cannot_be_in_the_past

  scope :in_progress, -> { where(status: "In Progress") }
  scope :done, -> { where(status: "Done") }

  def complete_by_cannot_be_in_the_past
    if complete_by.present? && complete_by < Date.today
      errors.add(:complete_by, "can't be in the past")
      errors.add(:base, "All your base")
    end
  end
end
