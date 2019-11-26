#!/bin/bash

set -e

git lfs unlock map.w3x/war3map.doo
NAME=$(id -u -n)
curl -d "content=$NAME%20has unlocked the map." https://discordapp.com/api/webhooks/648953529280495628/1u7I23u3Uc_u-82SL_ulxf15w7lf8SzwYEx_InZ8XxOOxvTTYI5rQQkqzaogF0IBKm5m