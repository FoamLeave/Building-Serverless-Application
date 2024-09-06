# Building-Serverless-Application

having problem with get request

https://us-east-1.console.aws.amazon.com/iam/home#/roles

- need to define the mapping template for each method

{
"httpMethod": "$context.httpMethod",
  "queryStringParameters": {
    "student_id": "$input.params('student_id')"
}
}

- json dumps then do json load problem

https://stackoverflow.com/questions/42354001/json-object-must-be-str-bytes-or-bytearray-not-dict

- reserved keywords

https://stackoverflow.com/questions/74920856/invalid-updateexpression-attribute-name-is-a-reserved-keyword-reserved-keyword
