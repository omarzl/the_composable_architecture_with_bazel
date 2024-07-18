# The Composable Architecture tutorial with Bazel

This project is the resulting code of the [tutorial](https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/meetcomposablearchitecture/) from [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture).

But compiling it with Bazel.

## SPM

To download the packages and generate Bazel targets, I used the rules from [rules_swift_package_manager](https://github.com/cgrindel/rules_swift_package_manager).

## How to run it?

1.- If you don't have Bazelisk installed, run: `brew install bazelisk`

2.- Then, you can create the Xcode project by running: `bazel run //:xcodeproj`

3.- Finally, just open the project `xed App.xcodeproj`

The `App` target runs the app, and the `UnitTests` target runs the tests.

## Modularization

I modularized the original tutorial into multiple Bazel targets:
- AddContactFeature
- ContactDetailFeature
- ContactFoundation
- ContactListFeature
- CounterFeature
