#!/usr/bin/env bash
rails generate scaffold_controller group_events
rails generate model GroupEvent name:string location:string description:text start_date:date duration:integer delete:boolean published:boolean
rake db:create
