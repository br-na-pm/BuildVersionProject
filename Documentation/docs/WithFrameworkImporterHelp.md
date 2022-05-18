# Build Version Task - With The Framework Importer

## 1. Select the Framework Importer Version

The first step is to ensure that a Framework Importer Version is selected.

![Framework Importer](images/Framework%20Importer%20Step%201.png)

## 2. Select BuildVersion to be imported
After opening the importer, you should select the BuildVersion from the list. The package can be imported with, or without the [MpView Widget Library](MpViewWidgetLibrary.md). 

## 3. Define the Pre-build Event
It is necessary to add the following to the pre-build events. The pre-build events is located under the Project-> Change Runtimes -> Build Events Tab

![Pre-Build Event](images/Framework%20Importer%20Step%203.png)

```powershell
PowerShell -ExecutionPolicy ByPass -File $(WIN32_AS_PROJECT_PATH)\Logical\BuildVersion\BuildVersion.ps1 "$(WIN32_AS_PROJECT_PATH)" "$(AS_VERSION)" "$(AS_USER_NAME)" "$(AS_PROJECT_NAME)" "$(AS_CONFIGURATION)" "$(AS_BUILD_MODE)"
```

After this step, the BuildVersion package is ready for use and the project can be compiled. The information can then be used in the application as desired.