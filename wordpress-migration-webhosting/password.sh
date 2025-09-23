# list users so you get the exact login name
docker compose exec wpcli wp user list --fields=ID,user_login,user_email,roles

# set a password you choose (example for user 'admin')
docker compose exec wpcli wp user update admin --user_pass='TempPass!2025'
