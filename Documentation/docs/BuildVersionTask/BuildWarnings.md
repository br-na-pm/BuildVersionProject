# Build Version Task - Build Warnings

Building a project with this package may result in warnings for additional files.  

![Build warnings 2022-03-31_12 34 35](../images/Build%20warnings%202022-03-31_12%2034%2035.png)

In Automation Studio 4.11+, it is possible to add specific filters to warnings 9232 and 9233.  Navigate to Configuration View, right-click the PLC object and select properties, chose the Build tab, and add the follow text to the "Objects ignored for build warnings 9232 and 9233" field. The filters are case sensitive.

```
*README*;*LICENSE*;.git;.gitignore;.github
```

Prior to Automation Studio 4.11, it is possible to suppress *all* build warnings regarding additional files by using `-W 9232 9233` in the "Additional build options" field.
