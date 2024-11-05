# Spotify Top Songs Global Pipeline

## Overview

This project automates the daily extraction of "Top Songs Global" information from Spotify and stores it in Snowflake using AWS services. The pipeline uses AWS Lambda for serverless computation and AWS S3 for temporary data storage.

## Architecture

![Architecture Diagram](spotify_pipeline.drawio.png)

## Features

- Daily extraction of Spotify's "Top Songs Global" data
- Serverless execution using AWS Lambda
- Temporary data storage in AWS S3
- Final data storage in Snowflake for analysis

## Prerequisites

- AWS account with access to Lambda and S3
- Spotify Developer account and API credentials
- Snowflake account and connection details

## Setup

1. Clone this repository
2. Set up AWS CLI and configure your credentials
3. Create an S3 bucket for temporary data storage
4. Create a Snowflake database and table for storing the extracted data
5. Set up a Spotify Developer account and obtain API credentials
6. Configure the Lambda function with necessary environment variables:
   - Spotify API credentials
   - S3 bucket name
   - Snowflake connection details

## Usage

The pipeline runs automatically on a daily basis. To manually trigger the pipeline:

1. Go to the AWS Lambda console
2. Find the function for this project
3. Click "Test" to run the function

## Data Flow

1. AWS Lambda function is triggered daily
2. Function calls Spotify API to fetch "Top Songs Global" data
3. Data is temporarily stored in AWS S3
4. Data is then loaded from S3 into Snowflake
5. Temporary data in S3 is deleted

## Acknowledgments

- Spotify for providing the API
- AWS for their serverless computing and storage solutions
- Snowflake for their data warehousing platform