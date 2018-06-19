#!/bin/bash


build_artifact=`grep exportLocation ${1} | cut -d '/' -f6`
sed -i "s/LCMBIAR/$build_artifact/" ${2}
