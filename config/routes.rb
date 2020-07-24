Rails.application.routes.draw do
  resources :survey_responses
  post 'survey_responses/sms' => 'survey_responses#sms'
end
