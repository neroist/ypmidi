# Package

version       = "0.1.1"
author        = "Jasmine"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["ypmidi"]


# Dependencies

requires "nim >= 1.6.10"
requires "paramidib"
requires "cligen"
requires "spinny"
requires "yaml"
