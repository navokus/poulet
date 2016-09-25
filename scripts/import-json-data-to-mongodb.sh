#!/bin/sh
mongoimport --db SmartD --collection Webs --username hackathon --password abc123 --upsert --file /home/lion/Desktop/Hackathon/$1

