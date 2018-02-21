# GoDaddy DDNS Public IP updater

Update the IP address of one or more of your records of one or more *GoDaddy* domain(s) every 5 minutes.

It uses bash and curl to communicate with the GoDaddy API, and is based on [Alpine](https://hub.docker.com/_/alpine/).
The image is **10MB** and requires **6MB** of RAM.

## Installation

### GoDaddy credentials

[![GoDaddy Website](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/godaddy.png)](https://godaddy.com)

1. Login to [https://developer.godaddy.com/keys](https://developer.godaddy.com/keys/) with your account credentials.

[![GoDaddy Developer Login](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/login.gif)](https://developer.godaddy.com/keys)

2. Generate a Test key and secret.

[![GoDaddy Developer Test Key](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/testkey.gif)](https://developer.godaddy.com/keys)

3. Generate a **Production** key and secret.

[![GoDaddy Developer Production Key](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/productionkey.gif)](https://developer.godaddy.com/keys)

Obtain the **key** and **secret** of that production key.

In this example, the key is `dLP4WKz5PdkS_GuUDNigHcLQFpw4CWNwAQ5` and the secret is `GuUFdVFj8nJ1M79RtdwmkZ`.

### Option 1 of 2: Docker container

[![Docker container](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/docker.png)](https://www.docker.com/)

1. Make sure you have [Docker](https://docs.docker.com/install/) installed
2. Obtaining the Docker image
    - Option 1 of 2: Download from Docker Hub automatically, so go directly to step 3.
    - Option 2 of 2: Build the image
        1. Download the repository files or `git clone` them
        2. With a terminal, go in the directory where the *Dockerfile* is located
        3. Build the image with:

            ```bash
            sudo docker build -t qmcgaw/godaddy-ip-ddns ./
            ```

3. Launching the Docker container from the image (replace the environment variables below with your own values):

    ```bash
    sudo docker run -d --name=godaddyddns --restart=always \
    -e 'TARGETS=[[mydomain.com,A,@];[mydomain2.com,A,*]]' \
    -e 'KEY=dLP4WKz5PdkS_GuUDNigHcLQFpw4CWNwAQ5' \
    -e 'SECRET=GuUFdVFj8nJ1M79RtdwmkZ' -e 'DELAY=1200' \
    qmcgaw/godaddy-ip-ddns
    ```

Note that we set the following container environment variables with the flag `-e`:

| **Environement variable** | **Value** | *Optional* |
| --- | --- | --- |
| TARGETS | Array containing `[`Domain name`,` Record type`,` Record name`]` | No |
| KEY | Production key's key | No |
| SECRET | Production key's secret | No |
| DELAY | `1200` | **Yes**, defaults to `300` |

You can also run the container interactively to test it with:

```bash
sudo docker run -it --rm --name=godaddyddnsTEST \
-e 'TARGETS=[[mydomain.com,A,@];[mydomain2.com,A,*]]' \
-e 'KEY=dLP4WKz5PdkS_GuUDNigHcLQFpw4CWNwAQ5' \
-e 'SECRET=GuUFdVFj8nJ1M79RtdwmkZ' -e 'DELAY=1200' \
qmcgaw/godaddy-ip-ddns
```

### Option 2 of 2: using the Shell script godaddyddns.sh

1. Set the necessary variables:
    - Option 1 of 2: Set environment variables with a terminal:
    
        ```shell
        TARGETS="[[mydomain.com,A,@];[mydomain2.com,A,*]]"
        KEY=dLP4WKz5PdkS_GuUDNigHcLQFpw4CWNwAQ5
        SECRET=GuUFdVFj8nJ1M79RtdwmkZ
        DELAY=1200 # optional
        ```
    
    - Option 2 of 2: Set variables in the shell script *godaddyddns.sh*
        1. Copy the following block of code:
        
            ```shell
            TARGETS="[[mydomain.com,A,@];[mydomain2.com,A,*]]"
            KEY=dLP4WKz5PdkS_GuUDNigHcLQFpw4CWNwAQ5
            SECRET=GuUFdVFj8nJ1M79RtdwmkZ
            DELAY=1200 # optional
            ```
        
        2. Paste it after the first line `#!/bin/sh`
2. Make the script executable with:

    ```shell
    sudo chmod +x godaddyddns.sh
    ```

3. Test the script by running it with:

    ```shell
    ./godaddyddns.sh
    ```

    Refer to the [Testing](#Testing) section to see the result.

4. Run the shell script with [screen](https://www.gnu.org/software/screen/) for example or as a service.

## Testing

With a browser, go to https://dcc.godaddy.com/manage/yourdomain.com/dns (replace yourdomain.com) and check the **Value** of the record of type **A** is set to your [current IP address](https://www.whatismyip.com/)

[![GoDaddy DNS management](https://github.com/qdm12/godaddy-ip-ddns/raw/master/readme/godaddydnsmanagement.png)](https://dcc.godaddy.com/manage/)

You might want to try to change the IP address to another one to see if the update actually occurs.
