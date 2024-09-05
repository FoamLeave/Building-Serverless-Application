import json
import boto3
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('StudentRecords')


def lambda_handler(event, context):
    logger.info(f"Received event: {json.dumps(event)}")

    http_method = event.get('httpMethod')

    if http_method == 'POST':
        try:
            # Ensure body is a dictionary
            body = json.loads(json.dumps(event['body']))
            if isinstance(body, str):
                body = json.loads(body)
            student = body
            logger.info(f"Student data: {student}")

            if not student or 'student_id' not in student or 'name' not in student or 'course' not in student:
                logger.error("Invalid input: Missing required fields.")
                return {
                    'statusCode': 400,
                    'body': json.dumps('Invalid input: student_id, name, and course are required.')
                }

            table.put_item(Item=student)
            logger.info("Student record added successfully")
            return {
                'statusCode': 200,
                'body': json.dumps('Student record added successfully')
            }
        except Exception as e:
            logger.error(
                f"Error adding student record: {str(e)}", exc_info=True)
            return {
                'statusCode': 500,
                'body': json.dumps(f'Error adding student record: {str(e)}')
            }

    elif http_method == 'GET':
        student_id = event.get('queryStringParameters', {}).get('student_id')
        if not student_id:
            logger.error("Missing student_id in query parameters.")
            return {
                'statusCode': 400,
                'body': json.dumps('Missing student_id in query parameters.')
            }

        try:
            response = table.get_item(Key={'student_id': student_id})
            item = response.get('Item')
            if not item:
                logger.error("Student record not found.")
                return {
                    'statusCode': 404,
                    'body': json.dumps('Student record not found.')
                }
            logger.info(f"Fetched student record: {item}")
            return {
                'statusCode': 200,
                'body': json.dumps(item)
            }
        except Exception as e:
            logger.error(
                f"Error fetching student record: {str(e)}", exc_info=True)
            return {
                'statusCode': 500,
                'body': json.dumps(f'Error fetching student record: {str(e)}')
            }

    elif http_method == 'DELETE':
        student_id = event.get('queryStringParameters', {}).get('student_id')
        if not student_id:
            logger.error("Missing student_id in query parameters.")
            return {
                'statusCode': 400,
                'body': json.dumps('Missing student_id in query parameters.')
            }

        try:
            response = table.delete_item(Key={'student_id': student_id})
            if response.get('Attributes'):
                logger.info("Student record deleted successfully")
                return {
                    'statusCode': 200,
                    'body': json.dumps('Student record deleted successfully')
                }
            else:
                logger.error("Student record not found.")
                return {
                    'statusCode': 404,
                    'body': json.dumps('Student record not found.')
                }
        except Exception as e:
            logger.error(
                f"Error deleting student record: {str(e)}", exc_info=True)
            return {
                'statusCode': 500,
                'body': json.dumps(f'Error deleting student record: {str(e)}')
            }

    elif http_method == 'PATCH':
        student_id = event.get('queryStringParameters', {}).get('student_id')
        if not student_id:
            logger.error("Missing student_id in query parameters.")
            return {
                'statusCode': 400,
                'body': json.dumps('Missing student_id in query parameters.')
            }

        update_body = json.loads(json.dumps(event['body']))
        if isinstance(update_body, str):
            update_body = json.loads(update_body)
        if not update_body:
            logger.error("Invalid input: No update data provided.")
            return {
                'statusCode': 400,
                'body': json.dumps('Invalid input: No update data provided.')
            }

        update_expression = "SET " + \
            ", ".join(f"{key}=:{key}" for key in update_body.keys())
        expression_values = {f":{key}": value for key,
                             value in update_body.items()}

        try:
            table.update_item(
                Key={'student_id': student_id},
                UpdateExpression=update_expression,
                ExpressionAttributeValues=expression_values
            )
            logger.info("Student record updated successfully")
            return {
                'statusCode': 200,
                'body': json.dumps('Student record updated successfully')
            }
        except Exception as e:
            logger.error(
                f"Error updating student record: {str(e)}", exc_info=True)
            return {
                'statusCode': 500,
                'body': json.dumps(f'Error updating student record: {str(e)}')
            }

    else:
        logger.error(f"Method {http_method} Not Allowed")
        return {
            'statusCode': 405,
            'body': json.dumps('Method Not Allowed. Only POST, GET, DELETE, and PATCH are supported.')
        }
