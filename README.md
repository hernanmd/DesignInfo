# Description

Collects package metrics (SLOC) in Pharo Smalltalk >= 6.1

# Screenshots

![Sorted comparison of packages in Pharo 6.1](https://user-images.githubusercontent.com/4825959/47520316-3d35cd00-d866-11e8-8091-bd758904290d.png)

![Comparison of packages in Pharo 6.1](https://user-images.githubusercontent.com/4825959/47520326-46269e80-d866-11e8-92fd-9311ffdc3288.png)


# Details

This is a [port from SqueakSource code](http://www.squeaksource.com/DesignInfo.html) to Pharo >= 6.1

A DesignInfo collects the following information and metrics about the design of a package:

  - lines of code
  - lines of production code
  - lines of test code
  - percentage of production code
  - percentage of test code

It can create morphs that show a bar chart of the lines of code of all Monticello packages, sorted either by package name or by lines of code. The bar chart also shows the percentage of production versus test code. Balloon help is used to show detailed information about a package.

# Ideas for enhancement

  - Allow combining production and test packages into one DesignInfo, e.g. Kernel and KernelTests
  - Support more metrics, e.g. public versus private methods, number of variables, package and class references
  - Separate UI into separate class
  - Allow changing the sort order in the lines of code morph
  
