# Ark Packages

Documentation for creating Ark packages as well as few example packages.

# Package format

## Package structure

Package definition is stored in a folder that contains package manifest and any additional package files.

A single package may contain multiple tasks and templates that are stored in corresponding sub-folders.

The default format for configuration files is JSON. Yaml may be supported in the future, but JSON files provide fewer options to make mistakes.

JSON files used in package definition support comments. Both single line (//) as well as block comments (/* */) are supported.
