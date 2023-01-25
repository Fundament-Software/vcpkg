# Fundament Software vcpkg Registry
This repository contains the vcpkg registry for Fundament Software projects and dependency overrides.

## Use in Manifest Mode
To use this in manifest mode, create a file in the root of your project (next to `vcpkg.json`) called `vcpkg-configuration.json`. Add the following to that file:

    {
      "registries": [
        {
          "kind": "git",
          "repository": "https://github.com/Fundament-Software/vcpkg",
          "baseline": "c68b75dbfe9f82ab7734b7b96a7a9dcb919d7e33",
          "packages": [ "feathergui", "innative", "llvm", "mimalloc", "scopes", "spirv-tools", "uvwasi" ]
        }
      ]
    }

If you already have a vcpkg-configuration.json file you can add the registry definition to your existing registries list.

## Use in Classic Mode
To use the registry in classic mode, simply place `vcpkg-configuration.json` in your vcpkg root directory rather than in a project's directory.
