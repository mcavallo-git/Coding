# ------------------------------------------------------------
#
# Get the latest image version (assuming Azure's numerical sorting is used and that the bottom-most version returned is latest)
#

az vm image list `
--all `
--sku "${IMAGE_SKU}" `
--publisher "${IMAGE_PUBLISHER}" `
--query "[?offer=='${IMAGE_OFFER}'] | sort_by([], &version) | [-1].version" `
--output "tsv" `
;


# ------------------------------------------------------------