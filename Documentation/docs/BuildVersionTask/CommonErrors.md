# Build Version Task - Common Errors

??? dropdown-ct "The argument "C:\projects\MyProject\Logical\BuildVersion\BuildVersion.ps1" to the -File parameter does not exist."
    - Possible cause: The pre-build event was created but the BuildVersion package was not added to the project. 
      - *Remedy*: Follow the [installation](./WithFrameworkImporterHelp.md) instructions to add existing package to the project.
    - Possible cause: The pre-build event created but does not point to the BuildVersion package. 
      - *Remedy*: Update the pre-build field's script path `$(WIN32_AS_PROJECT_PATH)\Logical\BuildVersion\BuildVersion.ps1` to match the path in the project

###

??? dropdown-ct "Object "C:\projects\MyProject\Logical\BuildVersion\BuildVer\Variable.var" doesn't exist."
    - Possible cause: The BuildVersion package was added to the project, but the pre-build event was not created.
      - *Remedy*: Follow the [installation](./WithFrameworkImporterHelp.md) instructions to create the pre-build event and ensure the prebuild event is present
  
      ```
        PowerShell -ExecutionPolicy ByPass -File $(WIN32_AS_PROJECT_PATH)\Logical\BuildVersion\BuildVersion.ps1 "$(WIN32_AS_PROJECT_PATH)" "$(AS_VERSION)" "$(AS_USER_NAME)" "$(AS_PROJECT_NAME)" "$(AS_CONFIGURATION)" "$(AS_BUILD_MODE)"
      ```

    - Possible cause: The local task was renamed and the PowerShell script cannot find it.
      - *Remedy*: Update the PowerShell script's `$ProgramName` parameter (default `"BuildVer"`) to match the task name in the project.

###

??? dropdown-ct "BuildVersion: Git in not installed or unavailable in PATH environment or BuildVersion: Please install git (git-scm.com) with recommended options for PATH"
    - Possible cause: Using the git client Sourcetree with the embedded git preference.
      - *Remedy*: Installing Sourcetree before installing git causes Sourcetree to default to its embedded git option. Sourcetree's embedded git is not available in the PATH environment. [Install git separately](https://git-scm.com/) with default installer options to add git to the PATH environment.
