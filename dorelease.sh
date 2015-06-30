#!/usr/bin/env bash

# IMPORTANT: Always update applist.txt from https://g5-app-wrangler.herokuapp.com/apps.json

version="master"
echo "Starting Release:"
i=1
while read p || [[ -n $p ]]; do
  echo ; echo ;
  echo "$i) Releasing to $p"
  if [[ $p == *"#"* ]]
  then
      echo "Skipping $p"
      i=$[$i+1]
      continue
  fi

  # echo "Stopping app..."
  # heroku ps:stop web --app "$p"

#    echo "Removing worker and scheduler dynos"
#    heroku ps:scale worker=0 --app "$p"
#    heroku ps:scale scheduler=0 --app "$p"

#  echo "Setting config"
  # heroku config:set HOST="https://$p.herokuapp.com" -a "$p"
  # heroku config:set G5_HUB=https://g5-hub.herokuapp.com -a "$p"
#  heroku config:set FURY_AUTH=msc9777J2TEEbgRsedKE -a "$p"

#  echo "Adding addons"
#  heroku addons:create deployhooks:http --url=https://$p.herokuapp.com/post_deploy_hook --app $p

#  echo "Unsetting config"
#  heroku config:unset HOST -a "$p"

#  echo "Backing up database"
#  heroku pg:backups capture -a $p

echo "Pushing release"
git push -f git@heroku.com:$p.git $version:master > ./logs/$p.log 2>&1 &

#    heroku restart --app $p

  # echo "Running migration..."
  # # We have to redirect stdin otherwise this command will consume the rest of the filenames
  # exec 6<&0      # Link file descriptor #6 with stdin.
  #                # Saves stdin.
  # exec < /dev/null
  # (heroku run rake db:migrate --app "$p" > ./logs/$p.log 2>&1 &)
  # exec 0<&6 6<&- # restore stdin

#  echo "Starting app..."
#  heroku ps:restart --app "$p" > ./logs/$p.log 2>&1 &

  i=$[$i+1]
done < $1

echo "Done"