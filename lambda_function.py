import os
import json
import logging
import requests

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def update_offer_status(offer_id, offer_status):
  url = os.environ['api_endpoint']
  request_body = {
    'offerId': offer_id,
    'offerStatus': offer_status,
  }
  headers = {
    'content-type': 'application/json'
  }

  return requests.put(url,
                      data=json.dumps(request_body),
                      headers=headers,
                      verify=False)


def lambda_handler(event, context):
  aws_connect_attribute = event['Details']['Parameters']
  logger.info('Amazon Connect: ' + json.dumps(aws_connect_attribute))

  offer_id = aws_connect_attribute['offerId']
  offer_status = aws_connect_attribute['offerStatus']

  response = update_offer_status(offer_id, offer_status)
  if response.status_code == 200:
    logger.info('Update offer status successful: ' + str(response.json()))
    return {
      'statusCode': 200,
    }
  else:
    logger.info('Update offer status failed: ' + str(response.json()))
    return {
      'statusCode': response.status_code,
      'message': response.json()['message']
    }
