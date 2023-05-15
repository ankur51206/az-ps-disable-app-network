Connect-AzAccount

foreach ($resourceId in Get-Content .\file.txt) {
    az webapp config access-restriction add --ids $resourceId --action true
}
