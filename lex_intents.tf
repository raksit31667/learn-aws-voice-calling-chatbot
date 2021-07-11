resource "aws_lex_intent" "accept_offer_intent" {
  name = "accept"

  fulfillment_activity {
    type = "ReturnIntent"
  }

  sample_utterances = [
    "Accept",
    "I accept",
    "Yes"
  ]
}

resource "aws_lex_intent" "reject_offer_intent" {
  name = "reject"

  fulfillment_activity {
    type = "ReturnIntent"
  }

  sample_utterances = [
    "Reject",
    "I Refuse",
    "No"
  ]
}

resource "aws_lex_intent" "repeat_offer_details_intent" {
  name = "repeatOfferDetails"

  fulfillment_activity {
    type = "ReturnIntent"
  }

  sample_utterances = [
    "Repeat",
    "Repeat offer details"
  ]
}

resource "aws_lex_intent" "repeat_options_intent" {
  name = "repeatOptions"

  fulfillment_activity {
    type = "ReturnIntent"
  }

  sample_utterances = [
    "Repeat options",
    "Repeat choices"
  ]
}
