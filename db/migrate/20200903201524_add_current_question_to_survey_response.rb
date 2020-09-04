class AddCurrentQuestionToSurveyResponse < ActiveRecord::Migration[6.0]
  def change
    rename_column :survey_responses, :question, :current_question
  end
end
