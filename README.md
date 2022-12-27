# Fundament Software vcpkg Registry
This repository contains the vcpkg registry for Fundament Software projects and dependency overrides.

## Use in Manifest Mode
To use this in manifest mode, create a file in the root of your project (next to `vcpkg.json`) called `vcpkg-configuration.json`. Add the following to that file:

    {
      "registries": [
        {
          "kind": "git",
          "repository": "https://github.com/Fundament-Software/vcpkg",
          "baseline": "347c7b2cb8cc1d9d37eff02d6a8a6b2730fea5d9",
          "packages": [ "feathergui", "innative", "llvm", "mimalloc", "scopes", "spirv-tools", "uvwasi" ]
        }
      ]
    }

If you already have a vcpkg-configuration.json file you can add the registry definition to your existing registries list.

## Use in Classic Mode
To use the registry in classic mode, simply place `vcpkg-configuration.json` in your vcpkg root directory rather than in a project's directory.