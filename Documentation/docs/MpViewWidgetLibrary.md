# Build Version Widget Library

This package serves a widget library to be paired with the [BuildVersion](https://github.com/br-na-pm/BuildVersion#readme) PowerShell script package.  
BuildVersion is a software package for Automation Studio to automatically collect version information from a git repository.  
This widget library provides single binding widgets to quickly display a range of git version information.  

**NOTE:** This is not an official package and is provided as-in under the GPL v3.0 license.

## Features

- Single structure binding
	- Users can simply use the existing structure defined in [BuildVersion](https://github.com/br-na-pm/BuildVersion#readme)
- Multiple compound widgets
	- Basic
	- Standard
	- Advanced
- Change warning indicator
	- Notify users when uncommitted changes are detected

## Widgets

**NOTE:** The warning icon appears to notify the user when the git repository has uncomitted changes.

### Basic

![Basic 2022-05-04_16 16 18](https://user-images.githubusercontent.com/33841634/166827533-790c8580-bb4d-4064-bab9-f032cb8c7505.png)

### Standard

![Standard 2022-05-04_16 17 12](https://user-images.githubusercontent.com/33841634/166827555-b5165760-0005-48ea-a79d-a54893dddb2d.png)

### Advanced

![Advanced 2022-05-04_16 17 47](https://user-images.githubusercontent.com/33841634/166827576-a97cc084-ee79-442f-8d36-2617ab059421.png)

## Binding

A single binding is required to populate the widgets with build information.  
Use the [BuildVersion](https://github.com/br-na-pm/BuildVersion) package with includes a task and variable to bind with `::BuildVer:BuildVersion`.

```xml
<Binding mode="oneWay">
  <Source xsi:type="opcUaComplexObject" refId="::BuildVer:BuildVersion" />
  <Target xsi:type="brease" contentRefId="content_0" widgetRefId="BuildVersionStandard1" attribute="value" />
</Binding>
```

## Version

The BuildVersionWidget library is supported with [BuildVersion package version 0.0.3 and later](https://github.com/br-na-pm/BuildVersion/releases).

