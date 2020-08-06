class SurveyResponse < ApplicationRecord
  validates_presence_of :from
  enum question: [ :story, :dream, :history ]
end
