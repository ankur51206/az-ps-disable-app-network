Connect-AzAccount

$subscriptionId = "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"

# Retrieve web app details for the subscription

$webApps = az webapp list --subscription $subscriptionId --query "[].{Name: name, Id: id}" --output json | ConvertFrom-Json

# Iterate over each web app and retrieve the access restrictions

foreach ($webApp in $webApps) {

    $webAppName = $webApp.Name

    $ipRestrictions = az webapp config access-restriction show --ids $webApp.Id --query "ipSecurityRestrictions" --output json | ConvertFrom-Json

    $ipRestrictions | Select-Object @{Name='WebAppName'; Expression={$webAppName}}, Action, Ip_Address, @{Name='Rule Name'; Expression={$_.Name}}, Priority | Format-Table -AutoSize

    Write-Host "----------------------"

# Export the output to CSV
$webApps | ForEach-Object {

    $webAppName = $_.Name

    $ipRestrictions = az webapp config access-restriction show --ids $_.Id --query "ipSecurityRestrictions" --output json | ConvertFrom-Json
    
    $ipRestrictions | Select-Object @{Name='WebAppName'; Expression={$webAppName}}, Action, Ip_Address, @{Name='Rule Name'; Expression={$_.Name}}, Priority

} | Export-Csv -Path "output.csv" 

}
