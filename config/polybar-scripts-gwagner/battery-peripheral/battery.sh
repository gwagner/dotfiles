#!/bin/bash -e

upower -i $1 | grep percentage | grep -o '[^ ]*%'