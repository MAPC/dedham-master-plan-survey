require 'twilio-ruby'

class SurveyResponsesController < ApplicationController
  include Webhookable
  before_action :set_survey_response, only: [:show, :update, :destroy, :sms]

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
      { }
    elsif survey_response.question1.blank?
      { question1: body }
    elsif survey_response.question2.blank?
      { question2: body }
    else
      { optout: true }
    end
  end

  def question(survey_response)
    if survey_response.question2.present?
      twiml_response('Thanks for completing our survey!')
    elsif survey_response.question1.present?
      twiml_response('What do you want to improve about Dedham?')
    else
      twiml_response('What do you love about Dedham?')
    end
  end
end
