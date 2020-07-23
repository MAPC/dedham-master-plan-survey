class CreateSurveyResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :survey_responses do |t|
      t.string :from
      t.string :question1
      t.string :question2
      t.boolean :optout

      t.timestamps
    end
  end
end
