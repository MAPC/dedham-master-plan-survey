require 'twilio-ruby'

class SurveyResponsesController < ApplicationController
  include Webhookable
  before_action :set_survey_response, only: [:show, :update, :destroy, :sms]

  QUESTIONS = {
    story: 'What’s your Dedham story? Think about when you first came to Dedham. Why did you come? What did you experience? Why do you stay? Have you always been here?',
    dream: 'What’s your dream for Dedham in 2030? What does the town look and feel like? Who do you spend your time with and where do you go? How is your dream of Dedham different than today?',
    history: 'Where does history live in Dedham? History lives in people, places, policy and so much more. What’s the untold history of the town? What’s your family history? Whose history has been forgotten? What’s the history that hasn’t been written yet?'
  }

  CONTENT = {
    disclaimer: 'The legal stuff: By sharing a response, you are agreeing to let the Metropolitan Area Planning Council (MAPC) and the Town of Dedham use your submission in the Designing Dedham 2030 master plan and in any publications hereafter',
    optin: 'Thanks for sharing your Dedham story! Do you want to receive updates about Designing Dedham 2030 and stay connected? Text 1 for yes, 2 for no.'
  }

  # GET /survey_responses
  def index
    @survey_responses = SurveyResponse.all
    render json: @survey_responses
  end

  # GET /survey_responses/1
  def show
    render json: @survey_response
  end

  # POST /survey_responses
  def create
    @survey_response = SurveyResponse.new(survey_response_params)

    if @survey_response.save
      render_twiml question(@survey_response), status: :created
    else
      render_twiml twiml_response('Sorry, there was an error. Please try again tomorrow.')
    end
  end

  # PATCH/PUT /survey_responses/1
  def update
    if survey_response_params.has_key?(:from) && @survey_response.update(survey_response_params)
      render_twiml question(@survey_response)
    else
      render_twiml twiml_response('Sorry, there was an error. Please try again tomorrow.')
    end
  end

  # DELETE /survey_responses/1
  def destroy
    @survey_response.destroy
  end

  def sms
    if @survey_response.blank?
      create
    else
      update
    end
  end

  private

  def set_survey_response
    @survey_response = params[:id].present? ? SurveyResponse.find(params[:id]) :
      SurveyResponse.find_by_from(params[:From])
  end

  def survey_response_params
    twilio_to_rails_params = ActionController::Parameters.new(
      {
        survey_response: {
          from: params.require(:From)
        },
        controller: params.require(:controller),
        action: params.require(:action)
      }
    ).permit!

    twilio_to_rails_params['survey_response'].merge!(assign_param(params['Body']).to_hash)
  end

  def assign_param(body)
    survey_response = SurveyResponse.find_by_from(params[:From])
    if survey_response.blank?
      { question: body }
    elsif survey_response.question1.blank?
      { question1: body }
    else
      { optout: body.to_i == 1 ? false : true }
    end
  end

  def question(survey_response)
    if !survey_response.optout.nil?
      twiml_response('Thanks for completing our survey!')
    elsif survey_response.question1.present?
      twiml_response(CONTENT[:optin])
    else
      twiml_response("#{CONTENT[:disclaimer]}\n\n#{QUESTIONS[survey_response.question.to_sym]}")
    end
  end
end
