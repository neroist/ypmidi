# Package

version       = "0.2.0"
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
requires "termui"
requires "yaml"
requires "fab"
