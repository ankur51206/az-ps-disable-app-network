Connect-AzAccount

$subscriptionId = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxx"

# Retrieve web app IDs for the subscription
$webAppIds = az webapp list --subscription $subscriptionId --query "[].id" --output tsv

# loop where each webapps shows the restrictions.
foreach ($webAppId in $webAppIds) {
    az webapp config access-restriction show --ids $webAppId --query "ipSecurityRestrictions" --output table
}
