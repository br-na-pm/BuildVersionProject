# Build Version Task - Without The Framework Importer

#### 1. Add Package to Project

- [Download](https://github.com/br-na-pm/BuildVersion/releases/latest/download/BuildVersion.zip) and extract the BuildVersion package
- Select Existing Package from the Automation Studio toolbox to import BuildVersion into logical view

![Step 1 2022-04-10_13-37-35](./images/Step%201%202022-04-10_13-37-35.gif)

#### 2. Create Pre-Build Event

- Under the active configuration, right-click the CPU object and select properties
- Find the build events tab and populate the pre-build field with the following prompt
- The pre-build event must be set for each configuration seeking version information

```powershell
PowerShell -ExecutionPolicy ByPass -File $(WIN32_AS_PROJECT_PATH)\Logical\BuildVersion\BuildVersion.ps1 "$(WIN32_AS_PROJECT_PATH)" "$(AS_VERSION)" "$(AS_USER_NAME)" "$(AS_PROJECT_NAME)" "$(AS_CONFIGURATION)" "$(AS_BUILD_MODE)"
```

![Step 2 2022-04-10_13-49-32](./images/Step%202%202022-04-10_13-49-32.gif)

Upon successful installation, users will see BuildVersion messages in the output results when building.

![BuildVersion output results 2022-04-10_13 48 16](./images/Step%201%202022-04-10_13-37-35.gif)

## Errors

> The argument "C:\projects\MyProject\Logical\BuildVersion\BuildVersion.ps1" to the -File parameter does not exist.

- Possible cause: The pre-build event was created but the BuildVersion package was not added to the project. 
  - *Remedy*: Follow the [installation](#installation) instructions to add existing package to the project.
- Possible cause: The pre-build event created but does not point to the BuildVersion package. 
  - *Remedy*: Update the [pre-build field's](#2-create-pre-build-event) script path `$(WIN32_AS_PROJECT_PATH)\Logical\BuildVersion\BuildVersion.ps1` to match the path in the project

> Object "C:\projects\MyProject\Logical\BuildVersion\BuildVer\Variable.var" doesn't exist.

- Possible cause: The BuildVersion package was added to the project, but the pre-build event was not created.
  - *Remedy*: Follow the [installation](#2-create-pre-build-event) instructions to create the pre-build event.
- Possible cause: The local task was renamed and the PowerShell script cannot find it.
  - *Remedy*: Update the PowerShell script's `$ProgramName` parameter (default `"BuildVer"`) to match the task name in the project.

> BuildVersion: Git in not installed or unavailable in PATH environment  
> BuildVersion: Please install git (git-scm.com) with recommended options for PATH  

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

## Build 

Building a project with this package may result in warnings for additional files.  

![Build warnings 2022-03-31_12 34 35](https://user-images.githubusercontent.com/33841634/161134955-5e71050f-bd1b-49cf-b07c-6408ae3c24ca.png)

In Automation Studio 4.11+, it is possible to add specific filters to warnings 9232 and 9233.  Navigate to Configuration View, right-click the PLC object and select properties, chose the Build tab, and add the follow text to the "Objects ignored for build warnings 9232 and 9233" field. The filters are case sensitive.

```
*README*;*LICENSE*;.git;.gitignore;.github
```

Prior to Automation Studio 4.11, it is possible to suppress *all* build warnings regarding additional files by using `-W 9232 9233` in the "Additional build options" field.
