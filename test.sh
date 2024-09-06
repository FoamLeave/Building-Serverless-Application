curl -X POST \
  https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students \
  -H 'Content-Type: application/json' \
  -d '{"student_id": "123", "name": "John Wick", "course": "Hacker Software"}'


curl -X POST \
  https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students \
  -H 'Content-Type: application/json' \
  -d '{"student_id": "1234", "name": "Some Random", "course": "Random Software"}'


curl -X POST \
  https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students \
  -H 'Content-Type: application/json' \
  -d '{"student_id": "12345", "name": "Test Test", "course": "Test Software"}'

curl -X GET "https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=123" 

curl -X GET "https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=1234" 

curl -X GET "https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=12345" 


curl -X PATCH \
 'https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=123' \
 -H 'Content-Type: application/json' \
 -d '{
"name": "John Wick Updated",
"course": "Hacker Software Advanced"
}'


curl -X PATCH \
 'https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=1234' \
 -H 'Content-Type: application/json' \
 -d '{
"name": "Something Updated",
"course": "Something Software"
}'


curl -X PATCH \
 'https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=12345' \
 -H 'Content-Type: application/json' \
 -d '{
"name": "Ok it is Updated",
"course": "oK Software Advanced"
}'



curl -X DELETE \
 'https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=123'


 curl -X DELETE \
 'https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=1234'


curl -X DELETE \
 'https://qk03j06gu7.execute-api.us-east-2.amazonaws.com/test/students?student_id=12345'




