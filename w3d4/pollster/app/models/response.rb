class Response < ActiveRecord::Base

  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_question_author

  belongs_to :answer_choice,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: "AnswerChoice"

  belongs_to :respondent,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "User"

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :question_author,
    through: :answer_choice,
    source: :question_author

  def sibling_responses
    self.question.responses.where('responses.id != ? OR ? IS NULL', self.id, self.id)
  end

  private

  def respondent_is_not_question_author
    if respondent == question_author
      errors[:user_id] << "can't answer own questions!"
    end
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(:user_id => self.user_id)
      errors[:user_id] << "can't answer question twice!"
    end
  end


end
