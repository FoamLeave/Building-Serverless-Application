curl -X POST \
  https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students \
  -H 'Content-Type: application/json' \
  -d '{ "student_id": "123", "name": "John Doe", "course": "Enterprise Software" }'
