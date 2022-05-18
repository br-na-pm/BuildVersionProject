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
