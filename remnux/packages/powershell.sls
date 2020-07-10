# Name: PowerShell  Core
# Website: https://github.com/powershell/powershell
# Description: Run PowerShell scripts and commands.
# Category: Dynamically Reverse-Engineer Code: Scripts, General Utilities
# Author: Microsoft Corporation
# License: MIT License: https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt
# Notes: pwsh

include:
  - remnux.repos.microsoft

powershell:
  pkg.installed:
    - pkgrepo: microsoft