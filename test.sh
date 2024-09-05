curl -X POST \
  https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students \
  -H 'Content-Type: application/json' \
  -d '{ "student_id": "123", "name": "John Doe", "course": "Enterprise Software" }'


{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "dynamodb:PutItem",
      "Resource": "arn:aws:dynamodb:us-east-2:124355661443:table/StudentRecords"
    }
  ]
}



import json
import boto3
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('StudentRecords')

def lambda_handler(event, context):
    # Check if the HTTP method is provided in the event
    http_method = event.get('httpMethod')
    
    if http_method == 'POST':
        # Create a new student record
        try:
            student = json.loads(event.get('body', '{}'))
            if not student or 'student_id' not in student or 'name' not in student or 'course' not in student:
                return {
                    'statusCode': 400,
                    'body': json.dumps('Invalid input: student_id, name, and course are required.')
                }
            
            table.put_item(Item=student)
            return {
                'statusCode': 200,
                'body': json.dumps('Student record added successfully')
            }
        except Exception as e:
            return {
                'statusCode': 500,
                'body': json.dumps(f'Error adding student record: {str(e)}')
            }

    elif http_method == 'GET':
        # Fetch student record by student_id
        student_id = event.get('queryStringParameters', {}).get('student_id')
        
        if not student_id:
            return {
                'statusCode': 400,
                'body': json.dumps('Missing student_id in query parameters.')
            }
        
        try:
            response = table.get_item(Key={'student_id': student_id})
            item = response.get('Item')
            if not item:
                return {
                    'statusCode': 404,
                    'body': json.dumps('Student record not found.')
                }
            return {
                'statusCode': 200,
                'body': json.dumps(item)
            }
        except Exception as e:
            return {
                'statusCode': 500,
                'body': json.dumps(f'Error fetching student record: {str(e)}')
            }

    else:
        return {
            'statusCode': 405,
            'body': json.dumps('Method Not Allowed. Only POST and GET are supported.')
        }
