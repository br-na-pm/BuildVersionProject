# Build Version Task - Common Errors

??? dropdown-ct "The argument "C:\projects\MyProject\Logical\BuildVersion\BuildVersion.ps1" to the -File parameter does not exist."
    - Possible cause: The pre-build event was created but the BuildVersion package was not added to the project. 
      - *Remedy*: Follow the [installation](#installation) instructions to add existing package to the project.
    - Possible cause: The pre-build event created but does not point to the BuildVersion package. 
      - *Remedy*: Update the [pre-build field's](#2-create-pre-build-event) script path `$(WIN32_AS_PROJECT_PATH)\Logical\BuildVersion\BuildVersion.ps1` to match the path in the project

###

??? dropdown-ct "Object "C:\projects\MyProject\Logical\BuildVersion\BuildVer\Variable.var" doesn't exist."
    - Possible cause: The BuildVersion package was added to the project, but the pre-build event was not created.
      - *Remedy*: Follow the [installation](#2-create-pre-build-event) instructions to create the pre-build event.
    - Possible cause: The local task was renamed and the PowerShell script cannot find it.
      - *Remedy*: Update the PowerShell script's `$ProgramName` parameter (default `"BuildVer"`) to match the task name in the project.

###

??? dropdown-ct "BuildVersion: Git in not installed or unavailable in PATH environment or BuildVersion: Please install git (git-scm.com) with recommended options for PATH"
    - Possible cause: Using the git client Sourcetree with the embedded git preference.
      - *Remedy*: Installing Sourcetree before installing git causes Sourcetree to default to its embedded git option. Sourcetree's embedded git is not available in the PATH environment. [Install git separately](https://git-scm.com/) with default installer options to add git to the PATH environment.

## Developers

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
