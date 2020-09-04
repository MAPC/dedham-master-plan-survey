class SurveyResponse < ApplicationRecord
  validates_presence_of :from
  enum current_question: [ :story, :dream, :history ]
end
