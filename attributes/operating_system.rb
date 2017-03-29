default['operating_system']['swapfile_name'] = "/var/swapfile"
default['operating_system']['swapfile_size_mb'] = "256"

#packages
default['operating_system']['packages']['essential'] = %w[git vim curl ncdu zlib1g-dev build-essential libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs libreadline-dev libmysqlclient-dev]
default['operating_system']['packages']['extra'] = %w[imagemagick libmagickcore-dev libmagickwand-dev]

