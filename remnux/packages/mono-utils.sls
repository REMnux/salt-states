# Name: monodis
# Website: https://www.mono-project.com/docs/tools+libraries/tools/monodis/
# Description: Disassemble and extract resources from .NET assemblies.
# Category: Examine Static Properties: .NET
# Author: Mono Project: https://www.mono-project.com
# License: MIT License: https://github.com/mono/mono/blob/main/LICENSE
# Notes: Use `monodis --mresources assembly.dll` to extract .NET manifest resources. Use `monodis --presources assembly.dll` to list resources without extracting.

include:
  - remnux.repos.mono

mono-utils:
  pkg.installed:
    - pkgrepo: mono-repo
