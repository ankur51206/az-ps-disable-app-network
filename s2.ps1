foreach ($resourceId in Get-Content .\file.txt) {
    az webapp config access-restriction add --ids $resourceId --rule-name 'IP example rule' --action Allow --ip-address 0.0.0.0/0 --priority 100
}
