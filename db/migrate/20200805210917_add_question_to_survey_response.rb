class AddQuestionToSurveyResponse < ActiveRecord::Migration[6.0]
  def change
    add_column :survey_responses, :question, :integer
  end
end
