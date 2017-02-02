#!/bin/bash -eux

# before updating packaages we add dependent sources here, so that we only
# need to call apt-get update once - otherwise we end up calling it three
# times as part of the install.
sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list'
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sh -c 'echo "deb https://cli-assets.heroku.com/branches/stable/apt ./" > /etc/apt/sources.list.d/heroku.list'

# add the keys for yarn, heroku and postgres
wget --quiet -O - http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
wget --quiet -O - https://cli-assets.heroku.com/apt/release.key | apt-key add -

if [[ $UPDATE  =~ true || $UPDATE =~ 1 || $UPDATE =~ yes ]]; then
	echo "==> Updating list of repositories"

    # apt-get update does not actually perform updates, it just downloads and indexes the list of packages
    apt-get -y update

    echo "==> Performing dist-upgrade (all packages and kernel)"
    apt-get -y dist-upgrade --force-yes
    reboot
    sleep 60
fi
