# Build Version Task - Without The Framework Importer

#### 1. Add Package to Project

- [Download](https://github.com/br-na-pm/BuildVersion/releases/latest/download/BuildVersion.zip) and extract the BuildVersion package
- Select Existing Package from the Automation Studio toolbox to import BuildVersion into logical view

![Step 1 2022-04-10_13-37-35](../images/Step%201%202022-04-10_13-37-35.gif)

#### 2. Create Pre-Build Event

- Under the active configuration, right-click the CPU object and select properties
- Find the build events tab and populate the pre-build field with the following prompt
- The pre-build event must be set for each configuration seeking version information

```powershell
PowerShell -ExecutionPolicy ByPass -File $(WIN32_AS_PROJECT_PATH)\Logical\BuildVersion\BuildVersion.ps1 "$(WIN32_AS_PROJECT_PATH)" "$(AS_VERSION)" "$(AS_USER_NAME)" "$(AS_PROJECT_NAME)" "$(AS_CONFIGURATION)" "$(AS_BUILD_MODE)"
```

![Step 2 2022-04-10_13-49-32](../images/Step%202%202022-04-10_13-49-32.gif)

Upon successful installation, users will see BuildVersion messages in the output results when building.

![BuildVersion output results 2022-04-10_13 48 16](../images/Step%201%202022-04-10_13-37-35.gif)
