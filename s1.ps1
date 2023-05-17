Connect-AzAccount

foreach ($resourceId in Get-Content .\file.txt) {
   az webapp config access-restriction show --ids $webAppId --query "ipSecurityRestrictions" --output table
}
