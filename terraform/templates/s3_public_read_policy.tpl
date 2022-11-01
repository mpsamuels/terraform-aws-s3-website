{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action":
                "s3:GetObject",
            "Principal":
                {
                    "AWS": "${cloudfront}"
                },
            "Effect":
                "Allow",
            "Sid":
                "PublicReadGetObject",
            "Resource":
                "arn:aws:s3:::${bucket}/*"
        }
    ]
}