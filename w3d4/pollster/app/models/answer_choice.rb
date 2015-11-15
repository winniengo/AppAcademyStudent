class AnswerChoice < ActiveRecord::Base

  validates :text, presence: true
  validates :question_id, presence: true

  belongs_to :question,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: "Question"

  has_many :responses,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: "Response"

  has_one :question_author,
    through: :question,
    source: :author
end
