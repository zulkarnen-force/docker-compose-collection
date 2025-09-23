docker compose exec wpcli wp core is-installed

# Set site home & siteurl to the new domain
docker compose exec wpcli wp option update home "https://dev.tabligh.id"
docker compose exec wpcli wp option update siteurl "https://dev.tabligh.id"

# Replace old domain with new across the DB (keeps serialized data intact)
docker compose exec wpcli wp search-replace 'http://tabligh.id' "http://dev.tabligh.id" --all-tables --precise --recurse-objects --skip-columns=guid
docker compose exec wpcli wp search-replace 'https://tabligh.id' "https://dev.tabligh.id" --all-tables --precise --recurse-objects --skip-columns=guid

# Flush permalinks
docker compose exec wpcli wp rewrite structure '/%postname%/' --hard
docker compose exec wpcli wp rewrite flush --hard

# make sure wp-cli sees the site

# set both URLs to dev.tabligh.id
docker compose exec wpcli wp option update home "https://dev.tabligh.id"
docker compose exec wpcli wp option update siteurl "https://dev.tabligh.id"

# (optional but useful) replace old domain anywhere in DB (serialized-safe)
docker compose exec wpcli wp search-replace 'https://tabligh.id' 'https://dev.tabligh.id' --all-tables --precise --recurse-objects --skip-columns=guid
docker compose exec wpcli wp search-replace 'http://tabligh.id'  'http://dev.tabligh.id' --all-tables --precise --recurse-objects --skip-columns=guid
