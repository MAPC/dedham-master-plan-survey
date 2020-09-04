class RenameQuestionColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :survey_responses, :question1, :story
    rename_column :survey_responses, :question2, :dream
    add_column :survey_responses, :history, :string
  end
end
