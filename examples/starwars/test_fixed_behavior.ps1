#!/usr/bin/env pwsh

# Test script to demonstrate the fixed GraphQL schema generation behavior
# This runs our fixed version directly instead of the system-installed one

Write-Host "🧪 Testing Fixed GraphQL Schema Generation" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

# Ensure we have an existing schema file to test conflict detection
if (-Not (Test-Path "schema_graphql.graphql")) {
    Write-Host "📝 Creating test schema file..." -ForegroundColor Yellow
    "type Query {`n    hello: String`n}" | Out-File -FilePath "schema_graphql.graphql" -Encoding UTF8
}

Write-Host ""
Write-Host "🔍 Current directory contents:" -ForegroundColor Cyan
Get-ChildItem -Filter "*schema*" | Select-Object Name, LastWriteTime | Format-Table

Write-Host ""
Write-Host "🚀 Running fixed schema generator..." -ForegroundColor Green
Write-Host "This will demonstrate early file conflict detection!" -ForegroundColor Green
Write-Host ""

# Set up classpath with Ballerina dependencies
$ballerinaLib = "C:\Program Files\Ballerina\distributions\ballerina-2201.12.7\bre\lib"
$fixedJar = "d:\Application files - Do not delete\github\ballerina-library\graphql-tools\graphql-schema-file-generator-0.13.0-fixed.jar"
$classpath = "$fixedJar;$ballerinaLib\*"

# Run the schema generator with our fixed version
& "C:\Program Files\Java\jdk-24\bin\java.exe" -cp $classpath io.ballerina.graphql.schema.SdlSchemaGenerator "service.bal" "."

Write-Host ""
Write-Host "✅ Test completed!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Final directory contents:" -ForegroundColor Cyan
Get-ChildItem -Filter "*schema*" | Select-Object Name, LastWriteTime | Format-Table

Write-Host ""
Write-Host "🎯 Expected behavior:" -ForegroundColor Yellow
Write-Host "  - Tool should detect existing schema_graphql.graphql" -ForegroundColor White
Write-Host "  - Tool should ask for user consent BEFORE processing" -ForegroundColor White  
Write-Host "  - If user says No, tool exits cleanly with no duplicates" -ForegroundColor White
Write-Host "  - If user says Yes, tool overwrites the existing file" -ForegroundColor White