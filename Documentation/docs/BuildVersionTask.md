# Build Version Task

The Build Version package uses 2 main components:

- Pre-Build Script
- BuildVersion Task

## Pre Build Script
The pre-build script is a Microsoft Powershell script that handles the interaction with git to parse out relevant version information for the project. The pre-build script also receives information from Automation Studio such as the Automation Studio version, PC name to include in your version information.

Additionally the script will create/update the BuildVersion.var file with the appropriate information for the current build.

!!! notice tips "Note"
    When first imported into a project, there will not be a .var file for the BuildVersion task. **This is by design**. The .var is generated from the script when it runs. Additionally a .gitignore file is present in the package to prevent this file from being stored in your git repository. As this file will change every compile, with every computer, tracking the changes is unnecessary.

There are [options](Script%20Options.md) to be enable/disable build warnings or errors upon user preference. Additional documentation on how the script functions and how it can be modified can be found inside the script itself. 

## BuildVersion Task
The BuildVersion task is a simple program that is solely present to give us previously created build version information available at runtime. The task itself only contains a single line which calls the BuildVersion variable so that the during compilation process the variable is not removed as being unused.

This task can be placed in any task class, however for simplicity it is recommended to be placed in TC8 or the lowest priority cyclic available.

## Deploying The Build Version Package

Deploying the package can be accomplished in one of two ways, with or without the Framework Importer tool. It is recommended to use the Framework importer tool.

1. [With The Framework Importer](WithFrameworkImporterHelp.md)
2. [Without The Framework Importer](WithoutFrameworkImporterHelp.md)
