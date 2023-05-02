load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")


http_archive(
    name = "io_bazel_rules_go",
    patch_args = ["-p1"],
    patches = [
        "//patches:cgopackages.patch",
    ],
    sha256 = "6b65cb7917b4d1709f9410ffe00ecf3e160edf674b78c54a894471320862184f",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.39.0/rules_go-v0.39.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.39.0/rules_go-v0.39.0.zip",
    ],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "727f3e4edd96ea20c29e8c2ca9e8d2af724d8c7778e7923a854b2c80952bc405",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.30.0/bazel-gazelle-v0.30.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.30.0/bazel-gazelle-v0.30.0.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("//:deps.bzl", "go_dependencies")

# gazelle:repository_macro deps.bzl%go_dependencies
go_dependencies()

go_rules_dependencies()

go_register_toolchains(version = "1.20.3")

gazelle_dependencies()

protobuf_version = "3.14.0"

http_archive(
    name = "com_google_protobuf",
    sha256 = "bf0e5070b4b99240183b29df78155eee335885e53a8af8683964579c214ad301",
    strip_prefix = "protobuf-" + protobuf_version,
    type = "zip",
    urls = [
        "https://github.com/protocolbuffers/protobuf/archive/v{}.zip".format(protobuf_version),
    ],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()



#
# zig cc
#

BAZEL_ZIG_CC_VERSION = "b4d067adbe246549ae5b6cdac209d1d6ad4b600a"

http_archive(
    name = "bazel-zig-cc",
    patch_args = ["-p1"],
    patches = [
        "//patches:bazel-zig-cc-fsanitize.patch",
        "//patches:bazel-zig-cc-glibc.patch",
        "//patches:bazel-zig-cc-launcher-diagnostics.patch",
    ],
    sha256 = "69fca706b56b2fceb2498728dad448b3ffc7a95fddd94a56376d7ace147b00cb",
    strip_prefix = "bazel-zig-cc-{}".format(BAZEL_ZIG_CC_VERSION),
    urls = [
        "https://git.sr.ht/~motiejus/bazel-zig-cc/archive/{}.tar.gz".format(BAZEL_ZIG_CC_VERSION),
    ],
)

load("@bazel-zig-cc//toolchain:defs.bzl", zig_toolchains = "toolchains")

# zig-cc toolchains can be enabled with `--extra_toolchains`. See README.
zig_toolchains(
    host_platform_sha256 = {
        "linux-aarch64": "5902b34b463635b25c11555650d095eb5030e2a05d8a4570c091313cd1a38b12",
        "linux-x86_64": "aa9da2305fad89f648db2fd1fade9f0f9daf01d06f3b07887ad3098402794778",
        "macos-aarch64": "51b4e88123d6cbb102f2a6665dd0d61467341f36b07bb0a8d46a37ea367b60d5",
        "macos-x86_64": "dd8eeae5249aa21f9e51ff4ff536a3e7bf2c0686ee78bf6032d18e74c8416c56",
    },
    url_formats = [
        "https://mirror.bazel.build/ziglang.org/builds/zig-{host_platform}-{version}.{_ext}",
        "https://ziglang.org/builds/zig-{host_platform}-{version}.{_ext}",
    ],
    version = "0.11.0-dev.1796+c9e02d3e6",
)
load("//rules:platform.bzl", "platforms_list")

# These C++ toolchains will only be considered when @zig_sdk//libc:flavor
# is set. That is usually done by providing a `--platforms=...` or by a
# transition.
[
    register_toolchains(
        "@zig_sdk//libc_aware/toolchain:{os}_{arch}_{libc}".format(
            arch = _plat.arch,
            libc = _plat.libc,
            os = _plat.os,
        ),
    )
    for _plat in platforms_list
]
