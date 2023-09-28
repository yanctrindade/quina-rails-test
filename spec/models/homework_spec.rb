require 'rails_helper'

RSpec.describe Homework, type: :model do
  # Associations
  describe 'associations' do
    it { should belong_to(:student).optional }
    it { should belong_to(:teacher).optional }
    it { should have_one_attached(:attachment) }
  end

  # Validations
  describe 'validations' do
    let(:homework) { Homework.new }

    it 'validates content type of attachment' do
      homework.attachment.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'sample.jpg')), filename: 'sample.jpg', content_type: 'image/jpeg')
      expect(homework).to be_valid

      homework.attachment.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'sample.txt')), filename: 'sample.txt', content_type: 'text/plain')
      expect(homework).not_to be_valid
    end
  end

  # Enum
  describe 'grades' do
    it { should define_enum_for(:grade).with_values(ungraded: 0, incomplete: 1, A: 2, B: 3, C: 4, D: 5, F: 6) }
  end

  # Scopes
  describe 'scopes' do
    before do
      @student_a = Student.create(name: "John")
      @student_b = Student.create(name: "Doe")
      
      @homework_a = Homework.create(grade: "A", assignment_name: "Assignment A", submitted_at: 3.days.ago, student: @student_a)
      @homework_b = Homework.create(grade: "B", assignment_name: "Assignment B", submitted_at: 2.days.ago, student: @student_b)
    end

    it '.by_grade' do
      expect(Homework.by_grade("A")).to eq [@homework_a]
    end

    it '.by_assignment_name' do
      expect(Homework.by_assignment_name("Assignment A")).to eq [@homework_a]
    end

    it '.by_date_range' do
      expect(Homework.by_date_range(4.days.ago, 1.day.ago)).to match_array [@homework_a, @homework_b]
    end

    it '.by_student_name' do
      expect(Homework.by_student_name("John")).to eq [@homework_a]
    end
  end

  # Callbacks
  describe 'callbacks' do
    let(:student) { Student.create(name: "John Doe") }
    let(:homework) { Homework.new(student: student) }

    it 'sets submitted_at before creation' do
      homework.save!
      expect(homework.submitted_at).to be_present
    end

    it 'sets student_name before creation' do
      homework.save!
      expect(homework.student_name).to eq "John Doe"
    end
  end
end
