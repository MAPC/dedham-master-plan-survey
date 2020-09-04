# Dedham Master Plan Survey Tool

This tool is an API that receives webhooks from a Twilio SMS endpoint to survey residents of Dedham about their master plan.

Documentaiton for Ruby and Twilio is on the [Twilio website](https://www.twilio.com/docs/sms/quickstart/ruby).

After deploying this application you need to set the webhook URL at Twilio to https://[DEPLOYMENT_URL]/survey_responses/sms in the [Twilio Console](https://www.twilio.com/console/phone-numbers/).

## Configure Twilio
For production set Twilio to webhook to http://dedham-master-plan-survey.mapc.org/survey_responses/sms.
