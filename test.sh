curl -X POST \
  https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students \
  -H 'Content-Type: application/json' \
  -d '{"student_id": "abc", "name": "John Wick", "course": "Hacker Software"}'







curl -X GET "https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=12344" 


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


curl -X PATCH \
 'https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=abc' \
 -H 'Content-Type: application/json' \
 -d '{
"name": "John Wick Updated",
"course": "Hacker Software Advanced"
}'

curl -X DELETE \
 'https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=123'



