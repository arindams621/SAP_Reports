#!/bin/bash

lcmbiar_file=`grep exportLocation /usr/sap/BIP/sap_bobj/export.properties | cut -d '/' -f6`
scp /usr/sap/BIP/sap_bobj/${lcmbiar_file} bouser@${1}:/usr/sap/BIP/sap_bobj/
