#!/usr/bin/env bash

apachectl -D FOREGROUND &
air -c /util/air.toml
