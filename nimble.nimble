import strutils

const
  parentDir = currentSourcePath.rsplit(seps={'/', '\\', ':'}, maxsplit=1)[0]

when fileExists(parentDir & "/src/nimblepkg/common.nim"):
  # In the git repository the Nimble sources are in a ``src`` directory.
  import src/nimblepkg/common
else:
  # When the package is installed, the ``src`` directory disappears.
  import nimblepkg/common

# Package

version       = nimbleVersion
author        = "Dominik Picheta"
description   = "Nim package manager."
license       = "BSD"

bin = @["nimble"]
srcDir = "src"
installExt = @["nim"]

# Dependencies

requires "nim >= 0.13.0"

when defined(nimdistros):
  import distros
  if detectOs(Ubuntu):
    foreignDep "libssl-dev"
  else:
    foreignDep "openssl"

task test, "Run the Nimble tester!":
  withDir "tests":
    exec "nim c -r tester"
