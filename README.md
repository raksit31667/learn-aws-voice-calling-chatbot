# Automated Voice Calling Chatbot in AWS

## How it works

1. **Amazon Connect** agent calls the user on designated phone number(s).
2. Once the user answers the call, Amazon Connect will pass over the user's context to the defined
   contact flow to start chatting with the bot.
3. **Amazon Polly** converts to speech and passes over to Amazon Connect to be relayed over to the
   user.
4. **Amazon Lex** bot receives the user’s speech and convert the user’s speech into text and pass it
   over to the Lambda function.
5. **AWS Lambda function** understands the user’s context and performs certain logics.
6. Amazon Connect collects Lambda function's outputs and conditionally response back to the user.

For each user response, switch or repeat step 3-5.

## Getting started

1. Log in to your Amazon Connect instance.
2. On the navigation menu, choose **Routing > Contact flows**, and create your contact flow.
3. Navigate to **Routing > Phone numbers**, and set up phone number for operators.
4. Navigate to **Routing > Hours of operation**, and set up working hours for operators.
5. Navigate to **Routing > Queues**, and choose to add or edit a queue. Then, choose Hours of
   operation from step 2, choose an **Outbound caller ID number** as defined step 1.
6. Define **Outbound caller ID name** as it will be displayed in user's phone when an operator
   initiates an outbound call.
7. Configure **Outbound whisper flow** to define experiences when user or agent joins in a
   conversation (read more on
   this [documentation](https://docs.aws.amazon.com/connect/latest/adminguide/set-whisper-flow.html)).

## Create a chatbot on Amazon Lex

> Amazon Lex is a service for building conversational interfaces into any application using voice and text. Amazon Lex provides the advanced deep learning functionalities of automatic speech recognition (ASR) for converting speech to text, and natural language understanding (NLU) to recognize the intent of the text, to enable you to build applications with highly engaging user experiences and lifelike conversational interactions. With Amazon Lex, the same deep learning technologies that power Amazon Alexa are now available to any developer, enabling you to quickly and easily build sophisticated, natural language, conversational bots (“chatbots”).

<https://aws.amazon.com/lex/>

### Terminologies

- **Intent** what user wants according to their speech.
- **Intent Classification** mapping between intents and actions.
- **Slots** data the user must provide to fulfill the intent. For example, the user wants to receive
  a free COVID-19 vaccine, then slots will be the follow-up questions like "Which vaccine do you
  prefer?". Therefore, user is expected to choose their favourite (e.g. Pfizer, Moderna, Johnson &
  Johnson, etc.)
- **Fulfillment** the business logic required to fulfill the intent. It can be either via AWS Lambda
  function, or return parameters to client.
- **Context** data passed back-and-forth between user response and bot response. It contains **slot
  status** and **session attributes**.
- **Session Attributes** the metadata about a conversation, generally used to share information
  between intents.

### Provision Lex with Terraform

TBD

### Lex configuration

- `x-amz-lex:max-speech-duration-ms:[intentName]:[slotToElicit]` how long the customer speaks before
  the input is truncated and returned to Amazon Connect.

- `x-amz-lex:start-silence-threshold-ms:[intentName]:[slotToElicit]` how long to wait before
  assuming that the customer isn't going to speak.

- `x-amz-lex:end-silence-threshold-ms:[intentName]:[slotToElicit]` how long to wait after the
  customer stops speaking before assuming the utterance has concluded.

See
this [admin guide](https://docs.aws.amazon.com/connect/latest/adminguide/get-customer-input.html)
for more details.

### Integration with Amazon Connect

1. Log in to your Amazon Connect instance.
2. On the navigation menu, choose **Routing > Contact flows**, and choose your contact flow.
3. Under Interact, drag a **Get customer input** block onto the designer, and connect it to the
   Entry point block.
4. To set speech to say or text to customers, select **Text-to-speech or chat text** and enter text.
5. Select an Amazon Lex bot.
6. See the result in **CloudWatch > Log groups > Your-Amazon-Connect-instance > Your-Log-stream**

Follow the instruction from
this [documentation](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-lex.html).

## Text-to-speech with Amazon Polly

> Amazon Polly is a service that turns text into lifelike speech.

<https://aws.amazon.com/polly/>

### Integration with Amazon Connect

1. Log in to your Amazon Connect instance.
2. On the navigation menu, choose **Routing > Contact flows**, and choose your contact flow.
3. Under Interact, drag a **Set voice** input block onto the designer, and connect it to the Entry
   point block.
4. Under Interact, drag **Play prompt** block in flow and select **Test-to-speech or chat text**
   then put the text.
5. See the result in **CloudWatch > Log groups > Your-Amazon-Connect-instance > Your-Log-stream**

## Invoke Amazon Lambda function

> AWS Lambda is a serverless compute service that lets you run code without provisioning or managing servers, creating workload-aware cluster scaling logic, maintaining event integrations, or managing runtimes.

<https://aws.amazon.com/lambda/>

## Integration with Amazon Connect

1. Log in to your Amazon Connect instance.
2. On the navigation menu, choose **Routing > Contact flows**, and choose your contact flow.
3. Under Interact, drag a **Set voice** input block onto the designer, and connect it to the Entry
   point block.
4. Under Interact, drag **Invoke AWS Lambda function** block in flow and fill in Lambda ARN, with
   parameters sent to Lambda if needed.
5. See the result in **CloudWatch > Log groups > Your-Amazon-Connect-instance > Your-Log-stream**

Follow the instructions from
this [documentation](https://docs.aws.amazon.com/connect/latest/adminguide/connect-lambda-functions.html).


