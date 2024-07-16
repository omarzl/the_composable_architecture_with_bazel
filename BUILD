load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load(
  "@build_bazel_rules_apple//apple:ios.bzl",
  "ios_application",
  "ios_unit_test",
  "ios_framework",
)
load(
    "@rules_xcodeproj//xcodeproj:defs.bzl",
    "top_level_target",
    "xcodeproj",
)
load("@gazelle//:def.bzl", "gazelle", "gazelle_binary")
load(
  "@rules_swift_package_manager//swiftpkg:defs.bzl",
  "swift_update_packages",
)

ios_application(
    name = "App",
    bundle_id = "com.omarzl.Demo",
    families = ["iphone"],
    infoplists = [":Demo/Info.plist"],
    minimum_os_version = "17.5",
    visibility = ["//visibility:public"],
    deps = [":DemoSources"],
)

swift_library(
    name = "DemoSources",
    srcs = glob(["Demo/*.swift"]),
    deps = [
        "@swiftpkg_swift_composable_architecture//:ComposableArchitecture",
    ],
)

gazelle_binary(
    name = "gazelle_bin",
    languages = [
        "@rules_swift_package_manager//gazelle",
    ],
)

swift_update_packages(
    name = "swift_update_pkgs",
    gazelle = ":gazelle_bin",
    generate_swift_deps_for_workspace = False,
    update_bzlmod_stanzas = True,
)

gazelle(
    name = "update_build_files",
    gazelle = ":gazelle_bin",
)