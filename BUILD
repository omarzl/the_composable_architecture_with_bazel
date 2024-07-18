load(
    "@build_bazel_rules_apple//apple:ios.bzl",
    "ios_application",
    "ios_framework",
    "ios_unit_test",
)
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@gazelle//:def.bzl", "gazelle", "gazelle_binary")
load(
    "@rules_xcodeproj//xcodeproj:defs.bzl",
    "top_level_target",
    "xcodeproj",
)

# App targets

ios_application(
    name = "App",
    bundle_id = "com.omarzl.Demo",
    families = ["iphone"],
    infoplists = [":Demo/Info.plist"],
    minimum_os_version = "16.0",
    visibility = ["//visibility:public"],
    deps = [":DemoSources"],
)

xcodeproj(
    name = "xcodeproj",
    project_name = "App",
    top_level_targets = [
        top_level_target(
            ":App",
            target_environments = ["simulator"],
        ),
        ":UnitTests",
    ],
)

# Library targets

swift_library(
    name = "DemoSources",
    module_name = "Demo",
    srcs = glob(["Demo/*.swift"]),
    deps = [
        ":ContactListFeature",
        "CounterFeature",
    ],
)

swift_library(
    name = "ContactDetailFeature",
    srcs = glob(["ContactDetailFeature/*.swift"]),
    deps = [
        ":ContactFoundation",
    ],
)

swift_library(
    name = "AddContactFeature",
    srcs = glob(["AddContactFeature/*.swift"]),
    deps = [
        ":ContactFoundation",
    ],
)

swift_library(
    name = "ContactListFeature",
    srcs = glob(["ContactListFeature/*.swift"]),
    deps = [
        ":ContactDetailFeature",
        ":AddContactFeature",
    ],
)

swift_library(
    name = "CounterFeature",
    srcs = glob(["CounterFeature/*.swift"]),
    deps = [
        "@swiftpkg_swift_composable_architecture//:ComposableArchitecture",
    ],
)

swift_library(
    name = "ContactFoundation",
    srcs = glob(["ContactFoundation/*.swift"]),
    deps = [
        "@swiftpkg_swift_composable_architecture//:ComposableArchitecture",
    ],
)

# Tests

swift_library(
    name = "DemoTests",
    testonly = True,
    srcs = glob(["Tests/*.swift"]),
    deps = [
        ":DemoSources",
    ],
)

ios_unit_test(
    name = "UnitTests",
    minimum_os_version = "16.0",
    deps = [
        ":DemoTests",
    ],
    platform_type = "ios",
    visibility = ["//visibility:public"],
)

# SPM

gazelle_binary(
    name = "gazelle_bin",
    languages = [
        "@rules_swift_package_manager//gazelle",
    ],
)

gazelle(
    name = "update_build_files",
    data = [
        "@swift_deps_info//:swift_deps_index",
    ],
    extra_args = [
        "-swift_dependency_index=$(location @swift_deps_info//:swift_deps_index)",
    ],
    gazelle = ":gazelle_bin",
)
