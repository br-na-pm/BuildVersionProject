# BuildVersion

**BuildVersion** is a software package for Automation Studio projects.  
The package includes a PowerShell script to automatically capture version information during a build.  
The script is intended for use with the version control system [git](https://git-scm.com/).  
The information captured is automatically initialized to a local and/or global variable in the project.  

!!!notice tips "NOTE"
    This is not an official package. BuildVersion is provided as-is under the GNU GPL v3.0 license agreement.  

![Initialize build version 2022-03-31_12 27 13](./images/Initialize%20build%20version%202022-03-31_12%2027%2013.png)


# Features
#### Local Variable Initialization

Following the installation instructions above, the local variable BuildVersion in the BuildVer program is automatically initialized with version information on any build. 
The entire variable declaration file is overwritten and automatically ignored by git to avoid frequent differences.

#### Global Variable Initialization

- Declare a variable with type `BuildVersionType` in the Global.var file. 
- The BuildVersion package will search for any variable of this type and initialize it with the version information on any build. 
- A confirmation message is written to the console regarding which variable was initialized.
- Aside from the variable of type `BuildVersionType`, the Global.var file will remain unchanged.
  
#### Configuration Version

Set the active configuration's version if the tag matches a `<major>.<minor>.<patch>` number format.

!!! notice danger "Expiremental"
    The above feature is still in an expiremental state and may not work as expected.

#### mappView Widgets
Varying level of detailed pre-built compound widgets for ease of deployment.

![Basic Widget](images/Basic%20BuildVersion%20Widget.png)
![Standard Widget](images/Standard%20BuildVersion%20Widget.png)
![Advanced Widget](images/Advanced%20BuildVersion%20Widget.png)



## Topics
- [Task](BuildVersionTask.md)
    - [Common Errors](./Common%20Errors.md)
    - [Build Warnings](./Build%20Warnings.md)
    - [Pre-Build Script Options](./Script%20Options.md)
- [WidgetLibrary](MpViewWidgetLibrary.md)