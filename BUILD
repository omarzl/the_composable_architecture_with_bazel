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
    ],
)

# Library targets

swift_library(
    name = "DemoSources",
    srcs = glob(["Demo/*.swift"]),
    deps = [
        "@swiftpkg_swift_composable_architecture//:ComposableArchitecture",
    ],
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
