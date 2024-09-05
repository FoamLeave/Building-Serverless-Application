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

