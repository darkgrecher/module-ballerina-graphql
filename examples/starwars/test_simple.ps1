# Test script to demonstrate the fixed GraphQL schema generation behavior

Write-Host "Testing Fixed GraphQL Schema Generation" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green

# Ensure we have an existing schema file to test conflict detection
if (-Not (Test-Path "schema_graphql.graphql")) {
    Write-Host "Creating test schema file..." -ForegroundColor Yellow
    "type Query {`n    hello: String`n}" | Out-File -FilePath "schema_graphql.graphql" -Encoding UTF8
}

Write-Host ""
Write-Host "Current directory contents:" -ForegroundColor Cyan
Get-ChildItem -Filter "*schema*" | Select-Object Name, LastWriteTime | Format-Table

Write-Host ""
Write-Host "Running fixed schema generator..." -ForegroundColor Green
Write-Host "This will demonstrate early file conflict detection!" -ForegroundColor Green
Write-Host ""

# Set up classpath with Ballerina dependencies
$ballerinaLib = "C:\Program Files\Ballerina\distributions\ballerina-2201.12.7\bre\lib"
$fixedJar = "d:\Application files - Do not delete\github\ballerina-library\graphql-tools\graphql-schema-file-generator-0.13.0-fixed.jar"
$classpath = "$fixedJar;$ballerinaLib\*"

# Run the schema generator with our fixed version
& "C:\Program Files\Java\jdk-24\bin\java.exe" -cp $classpath io.ballerina.graphql.schema.SdlSchemaGenerator "service.bal" "."

Write-Host ""
Write-Host "Test completed!" -ForegroundColor Green