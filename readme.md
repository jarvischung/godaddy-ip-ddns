# GoDaddy DDNS Public IP updater

[![Build Status](https://travis-ci.org/qdm12/godaddy-ip-ddns.svg?branch=master)](https://travis-ci.org/qdm12/godaddy-ip-ddns)

Update the IP address of one or more of your records of one or more *GoDaddy* domain(s) every 5 minutes.

[![](https://images.microbadger.com/badges/image/qmcgaw/godaddy-ip-ddns.svg)](https://microbadger.com/images/qmcgaw/godaddy-ip-ddns "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/qmcgaw/godaddy-ip-ddns.svg)](https://microbadger.com/images/qmcgaw/godaddy-ip-ddns "Get your own version badge on microbadger.com")

The image is **10MB** and requires **6MB** of RAM.

Based on:
- Bash
- Curl
- [Alpine Linux](https://hub.docker.com/_/alpine/).

## Installation

### 1. GoDaddy credentials

[![GoDaddy Website](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/godaddy.png)](https://godaddy.com)

1. Login to [https://developer.godaddy.com/keys](https://developer.godaddy.com/keys/) with your account credentials.

[![GoDaddy Developer Login](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/login.gif)](https://developer.godaddy.com/keys)

2. Generate a Test key and secret.

[![GoDaddy Developer Test Key](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/testkey.gif)](https://developer.godaddy.com/keys)

3. Generate a **Production** key and secret.

[![GoDaddy Developer Production Key](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/productionkey.gif)](https://developer.godaddy.com/keys)

Obtain the **key** and **secret** of that production key.

In this example, the key is `dLP4WKz5PdkS_GuUDNigHcLQFpw4CWNwAQ5` and the secret is `GuUFdVFj8nJ1M79RtdwmkZ`.

### 2. Installing and running

#### Option 1 of 3: Docker Compose

1. Make sure you have [Docker](https://docs.docker.com/install/) installed
1. Download [**docker-compose.yml**](https://github.com/qdm12/godaddy-ip-ddns/blob/master/docker-compose.yml)
1. Edit it as you wish (see [the section on environment variables](#environment-variables)
1. Launch the container with `docker-compose up -d`

#### Option 2 of 3: Docker container

[![Docker container](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/docker.png)](https://www.docker.com/)

1. Make sure you have [Docker](https://docs.docker.com/install/) installed
1. Launch the Docker container from the image with:

    ```bash
    sudo docker run -d --name=godaddyddns --restart=always \
    -e TARGETS=[[mydomain.com,A,@];[mydomain2.com,A,*]] \
    -e KEY=dLP4WKz5PdkS_GuUDNigHcLQFpw4CWNwAQ5 \
    -e SECRET=GuUFdVFj8nJ1M79RtdwmkZ -e DELAY=1200 \
    qmcgaw/godaddy-ip-ddns
    ```

Replace the environment variables with your own values, refer to 
[the section on environment variables](#environment-variables)

### Option 3 of 3: using the Bash script godaddyddns.sh directly

1. Set the necessary variables

    ```shell
    TARGETS="[[mydomain.com,A,@];[mydomain2.com,A,*]]"
    KEY=dLP4WKz5PdkS_GuUDNigHcLQFpw4CWNwAQ5
    SECRET=GuUFdVFj8nJ1M79RtdwmkZ
    DELAY=1200 # optional
    ```

    - Option 1 of 2: Set environment variables with a terminal
    - Option 2 of 2: Paste this block of code in *godaddyddns.sh* after the first line `#!/bin/sh`
    - Replace the values with your own values, refer to 
    [the section on environment variables](#environment-variables)
1. Make the script executable with:

    ```shell
    sudo chmod +x godaddyddns.sh
    ```

1. Test the script by running it with:

    ```shell
    ./godaddyddns.sh
    ```

1. Run the shell script with [screen](https://www.gnu.org/software/screen/) for example or as a service.

### Environement variables

| **Environement variable** | **Value** | *Optional* |
| --- | --- | --- |
| TARGETS | Array containing `[`Domain name`,` Record type`,` Record name`]` | No |
| KEY | Production key's key | No |
| SECRET | Production key's secret | No |
| DELAY | `1200` | **Yes**, defaults to `300` |

## 3. Testing

With a browser, go to https://dcc.godaddy.com/manage/yourdomain.com/dns (replace yourdomain.com) 
and check the **Value** of the record of type **A** is set to your 
[current IP address](https://www.whatismyip.com/)

[![GoDaddy DNS management](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/godaddydnsmanagement.png)](https://dcc.godaddy.com/manage/)

You might want to try to change the IP address to another one to see if the update actually occurs.