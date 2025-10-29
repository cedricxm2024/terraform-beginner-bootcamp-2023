#!/usr/bin/env bash

set -e

echo "=== Terraform Configuration Tests ==="
echo ""

# Test 1: Terraform Format Check
echo "Test 1: Checking Terraform formatting..."
if terraform fmt -check -recursive; then
  echo "✅ All Terraform files are properly formatted"
else
  echo "❌ Terraform files need formatting"
  exit 1
fi
echo ""

# Test 2: Terraform Validation
echo "Test 2: Validating Terraform configuration..."
if terraform validate; then
  echo "✅ Terraform configuration is valid"
else
  echo "❌ Terraform configuration validation failed"
  exit 1
fi
echo ""

# Test 3: Check for misplaced cloud block
echo "Test 3: Checking for misplaced cloud block..."
if grep -n "^  cloud {" modules/video_game/main.tf; then
  echo "❌ Found cloud block outside terraform block"
  exit 1
else
  echo "✅ No misplaced cloud block found"
fi
echo ""

# Test 4: Verify random provider is declared
echo "Test 4: Checking random provider declaration..."
if grep -A 10 "required_providers" modules/video_game/main.tf | grep -q "random"; then
  echo "✅ Random provider is properly declared"
else
  echo "❌ Random provider is missing from required_providers"
  exit 1
fi
echo ""

# Test 5: Check for S3 bucket policy security condition
echo "Test 5: Verifying S3 bucket policy has security condition..."
if grep -A 15 "aws_s3_bucket_policy" modules/video_game/main.tf | grep -q "AWS:SourceArn"; then
  echo "✅ S3 bucket policy has proper security condition"
else
  echo "❌ S3 bucket policy missing security condition"
  exit 1
fi
echo ""

# Test 6: Check for deprecated s3_origin_config with OAC
echo "Test 6: Checking CloudFront origin configuration..."
if grep -A 5 "origin_access_control_id" modules/video_game/main.tf | grep -q "s3_origin_config"; then
  echo "❌ Found s3_origin_config with origin_access_control_id (incompatible)"
  exit 1
else
  echo "✅ CloudFront origin configuration is correct"
fi
echo ""

# Test 7: Verify depends_on is inside resource block
echo "Test 7: Verifying depends_on is properly placed..."
if grep -B 25 "depends_on.*cloudfront" modules/video_game/main.tf | grep -q "resource.*bucket_policy"; then
  echo "✅ depends_on is properly placed inside resource block"
else
  echo "❌ depends_on is not properly placed"
  exit 1
fi
echo ""

echo "=== All Tests Passed ✅ ==="
