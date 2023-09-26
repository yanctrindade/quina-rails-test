class Homework < ApplicationRecord
  belongs_to :student, optional: true
  belongs_to :teacher, optional: true
  has_one_attached :attachment
  
  enum grade: {
    ungraded: 0,
    incomplete: 1,
    A: 2,
    B: 3,
    C: 4,
    D: 5,
    F: 6
  }

  validates :attachment, attached: true, content_type: ['image/jpeg', 'application/pdf']

  before_create :set_submitted_at

  private

  def set_submitted_at
    self.submitted_at = Time.current
  end
end
