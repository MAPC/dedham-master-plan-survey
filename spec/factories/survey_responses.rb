FactoryBot.define do
  factory :survey_response do
    from { "7728675309" }
    question1 { "Response to the first survey question." }
    question2 { "Response to the second survey question." }
    optout { false }
  end
end
