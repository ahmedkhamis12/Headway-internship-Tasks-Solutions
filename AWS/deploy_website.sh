#!/bin/bash

# Create an index.html file with custom content 
echo "<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Welcome to My Static Website</title>
</head>
<body>
    <h1>Welcome to My Static Website!</h1>
    <p>Hello Headway interns !.</p>
    <img src=\"cr7.jpg\" alt=\"My Image\" style=\"max-width: 100%; height: auto;\">
</body>
</html>" > index.html



# Enable static website hosting on the S3 bucket
aws s3 website s3://headway-bucket-website/ --index-document index.html

echo "S3 bucket headway-bucket-website configured for static website hosting."

# Upload the index.html file to the S3 bucket
aws s3 cp index.html s3://headway-bucket-website/

echo "index.html uploaded to S3 bucket headway-bucket-website."

# Upload the image file to the S3 bucket
aws s3 cp cr7.jpg s3://headway-bucket-website/

echo "cr7.png uploaded to S3 bucket headway-bucket-website."

# Set the bucket policy to allow public access
aws s3api put-bucket-policy --bucket headway-bucket-website --policy '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::headway-bucket-website/*"
        },
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::headway-bucket-website/*"
        }
    ]
}'

echo "Bucket policy set to allow public access."

# The Link of the website
echo "The static website is now live at: http://headway-bucket-website.s3-website-us-east-1.amazonaws.com"
