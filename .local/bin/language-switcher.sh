#!/bin/sh

# Script that switch between languages

if setxkbmap -query | grep -q us; then
  setxkbmap -layout br;
else
  setxkbmap -layout us;
fi
