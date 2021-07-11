resource "aws_lex_bot" "free_covid_vaccine_bot" {

  name = "FreeCovidVaccineBot"

  description = "Bot to offer free COVID-19 vaccine for our mankind"

  child_directed = false

  enable_model_improvements = true

  abort_statement {
    message {
      content      = "Sorry, I am not able to assist at this time"
      content_type = "PlainText"
    }
  }

  clarification_prompt {
    max_attempts = 2

    message {
      content      = "I didn't understand you, can you repeat it again?"
      content_type = "PlainText"
    }
  }

  intent {
    intent_name    = aws_lex_intent.accept_offer_intent.name
    intent_version = aws_lex_intent.accept_offer_intent.version
  }

  intent {
    intent_name    = aws_lex_intent.reject_offer_intent.name
    intent_version = aws_lex_intent.reject_offer_intent.version
  }

  intent {
    intent_name    = aws_lex_intent.repeat_offer_details_intent.name
    intent_version = aws_lex_intent.repeat_offer_details_intent.version
  }

  intent {
    intent_name    = aws_lex_intent.repeat_options_intent.name
    intent_version = aws_lex_intent.repeat_options_intent.version
  }
}
