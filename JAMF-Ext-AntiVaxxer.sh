#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	JAMF-Ext-AntiVaxxer.sh
#	https://github.com/Headbolt/JAMF-Ext-AntiVaxxer
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#       Look at the Update set and check if it is in the list of updates to be ignored
#
###############################################################################################################################################
#
# HISTORY
#
#   Version: 1.1 - 03/03/2021
#
#   - 05/02/2021 - V1.0 - Created by Headbolt
#
#   - 03/03/2021 - V1.1 - Updated by Headbolt
#							Across versions, the way Quote marks are dealt with seems flaky and makes the logic checks
#							occasionally unreliable, the strings have therefore been stripped of quotes after initial use,
#							which still needs them, the 2 new variables are now used for the IF statements
#
###############################################################################################################################################
#
#   DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
Update='"macOS Big Sur"' # Set the Update to check for eg. '"macOS Big Sur"' Quotes will be needed so single quotes outside double quotes
#
###############################################################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
# 
# Begin Processing
#
###############################################################################################################################################
#
UpdateSuppressed=$(/usr/sbin/softwareupdate --ignore | grep "$Update") # Check the List of Ignored Updates for the one we are looking for.
#
UpdateRAW=$(/bin/echo $Update | cut -c 2- | rev | cut -c 2- | rev ) # Cut the Double Quotes off each end of the string.
UpdateSuppressedRAW=$(/bin/echo $UpdateSuppressed | cut -c 2- | rev | cut -c 2- | rev ) # Cut the Double Quotes off each end of the string.
#
if [[ "$UpdateRAW" == "$UpdateSuppressedRAW" ]] # Check if Named update was on the list.
	then
		Result="YES"
	else
		Result="NO"
fi
#
#
/bin/echo "<result>$Result</result>" # Write Result out
