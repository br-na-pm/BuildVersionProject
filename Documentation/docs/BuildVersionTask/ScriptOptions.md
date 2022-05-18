# Build Version Task - Pre Build Script Options

The PowerShell script provides several options for naming, error severity, and build reaction.  
By default, the PowerShell script will not generate a build error (if installed correctly).  
However, developers may wish to enable more severe build reactions given the git version information. The options are detailed below and can be enabled by setting the `$True` constant in BuildVersion.ps1.

```powershell
############
# Parameters
############
# The script will search under Logical to find this program (e.g. .\Logical\BuildVersion\BuildVer)
$ProgramName = "BuildVer"
# The script will search under Logical to find this variable file (e.g. .\Logical\Global.var)
$GlobalDeclarationName = "Global.var"
# The script will search for variables of this type
$TypeIdentifier = "BuildVersionType"

# Use $True or $False to select options
# Create build error if the script fails to due missing arguments
$OptionErrorOnArguments = $False
# Create build error if git is not installed or no git repository is found in project root
$OptionErrorOnRepositoryCheck = $False 
# Create build error if uncommitted changes are found in git repository
$OptionErrorOnUncommittedChanges = $False
# Create build error if neither a local or global variable is initialized with version information
$OptionErrorIfNoInitialization = $False
```
