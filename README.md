D3 Chart
=======

##Setting up your development machine

You should install the following on your development machine:

###RVM and Ruby
```sh
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
$ curl -sSL https://get.rvm.io | bash
$ rvm install 2.0.0 #in new terminal
```

###Create gemset
```sh
$ rvm use 2.0.0@d3_chart --create --default
```

###Git
```sh
$ sudo apt-get install git
```

###NodeJs
```sh
$ curl https://raw.githubusercontent.com/creationix/nvm/v0.11.1/install.sh | bash
$ source ~/.profile
$ nvm install 0.10.33 #in new terminal
```

###Rails
```sh
$ gem install rails
```

###Clone project

```sh
$ git clone git@github.com:dmytrokomisaryk/D3_Chart.git
$ cd D3_Chart
```

###Install gems

```sh
$ bundle install
```

###Run app

```sh
$ rails s
```
