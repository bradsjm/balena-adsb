# balena-adsb

This repository provides a multi-container project for adsb receiving and submission to multiple websites optionally deployed using [balenaCloud](https://www.balena.io/cloud) to Raspberry PI devices.

The balena base images [balenalib/raspberrypi3-alpine](https://hub.docker.com/r/balenalib/raspberrypi3-alpine) and [balenalib/raspberrypi3-debian](https://hub.docker.com/r/balenalib/raspberrypi3-debian) are used for all builds.

Supporting input feed using an RTLSDR USB device via dump1090.

Supporting outputs to the following sites:
* https://adsbexchange.com
* https://www.adsbhub.org
* https://flightaware.com
* https://flightradar24.com
* https://opensky-network.org
* https://planefinder.net
* https://radarbox24.com/

and local viewing via:
* [modesmixer2](http://xdeco.org/?page_id=48) web UI on port 8080

To get this project up and running, you will first need to signup for a balenaCloud account [here](https://dashboard.balena-cloud.com/signup), create an application, and add a device. Have a look at the [Getting Started guide](https://www.balena.io/docs/learn/getting-started) if you need help.

Once you are set up with an account, you will need to clone this repo locally:
```
$ git clone https://github.com/bradsjm/balena-adsb.git
```
Then add your application's remote repository to your local repository (replace the following with your URL provided by balenaCloud):
```
$ git remote add balena username@git.balena-cloud.com:username/myapp.git
```
and push the code to the newly added remote:
```
$ git push --set-upstream balena master
```

### Setup:
You will need to add and configure environment variables in balenaCloud (or modify the docker-compose.yml) including:

* DD_API_KEY (for optional use of Datadog monitoring)
* FR24FEED_KEY (Flightradar 24 key)
* LATITUDE (your latitude)
* LONGITUDE (your longitude)
* ALTITUDE (your altitude)
* GOOGLE_KEY (optional google key for mapping)
* MLAT_CLIENT_USER (adsb exchange MLAT user)
* OPENSKY_USER (opensky username)
* OPENSKY_SERIAL (opensky serial)
* FLIGHTAWARE_USERNAME (flightaware username)
* FLIGHTAWARE_PASSWORD (flightaware password)
* FLIGHTAWARE_FEEDER_ID (flightaware feeder id)
* RADARBOX24_KEY (radarbox 24 key)

### Optional Direwolf APRS gateway
This project includes Direwolf for using a second RTL-SDR to provide a Amateur Radio APRS gateway. To use this you will need to set the following environment variables:
* MYCALL (your ham radio callsign)
* IGLOGIN (internet gateway login and passcode)
* IGSERVER (internet gateway server if not using north america)
* FREQUENCY (custom aprs frequency if outside the US)
