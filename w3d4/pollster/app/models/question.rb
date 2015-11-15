class Question < ActiveRecord::Base

  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to :poll,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: "Poll"

  has_many :answer_choices,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: "AnswerChoice"

  has_many :responses,
    through: :answer_choices,
    source: :responses

  has_one :author,
    through: :poll,
    source: :author
end
