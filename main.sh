read -p "Enter Registration Mail > " email
read -p "Enter a Password > " password


curl -X POST https://playit.gg/login/create \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode "email=$email" \
  --data-urlencode "password=$password" \
  --data-urlencode "confirm-password=$password" \
  --data-urlencode '_action=create'
  
echo "Created!"
  
echo "Now You'll get the login cookie"
  
login_cookie=$(
  curl -v 'https://playit.gg/login?_data=routes%2Flogin' \
       -X POST \
       -H 'Content-Type: application/x-www-form-urlencoded' \
       --data-urlencode '_action=login' \
       --data-urlencode "email=$email" \
       --data-urlencode "password=$password" 2>&1 \
  | grep -i 'Set-Cookie:' \
  | sed -e 's/^.*__session=\([^;]*\).*$/\1/'
)

echo $login_cookie
