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

# Test 3: Check for misplaced depends_on
echo "Test 3: Checking for misplaced depends_on statements..."
if grep -n "^depends_on" modules/video_game/main.tf; then
  echo "❌ Found depends_on outside resource block"
  exit 1
else
  echo "✅ No misplaced depends_on statements found"
fi
echo ""

# Test 4: Check for deprecated s3_origin_config with OAC
echo "Test 4: Checking CloudFront origin configuration..."
if grep -A 5 "origin_access_control_id" modules/video_game/main.tf | grep -q "s3_origin_config"; then
  echo "❌ Found s3_origin_config with origin_access_control_id (incompatible)"
  exit 1
else
  echo "✅ CloudFront origin configuration is correct"
fi
echo ""

# Test 5: Verify depends_on is inside resource block
echo "Test 5: Verifying depends_on is properly placed..."
if grep -B 20 "depends_on.*cloudfront" modules/video_game/main.tf | grep -q "resource.*gameing_bucket_policy"; then
  echo "✅ depends_on is properly placed inside resource block"
else
  echo "❌ depends_on is not properly placed"
  exit 1
fi
echo ""

echo "=== All Tests Passed ✅ ==="
