load("@bazel_skylib//lib:structs.bzl", "structs")

def _platform(os, arch, libc, name, distro = None):
    return struct(
        os = os,
        arch = arch,
        libc = libc,
        name = name,
        distro = distro,
    )

# platforms is a list of os_arch and gnu choices, named
# after the distribution with that gnu version.
platforms = struct(
    # distro not supported for jessie, as we don't build jessie containers anymore
    jessie_amd64 = _platform("linux", "amd64", "gnu.2.19", "jessie_amd64"),
    stretch_amd64 = _platform("linux", "amd64", "gnu.2.24", "stretch_amd64", distro = "stretch"),
    buster_amd64 = _platform("linux", "amd64", "gnu.2.28", "buster_amd64", distro = "buster"),
    bullseye_amd64 = _platform("linux", "amd64", "gnu.2.31", "bullseye_amd64", distro = "bullseye"),
    musl_amd64 = _platform("linux", "amd64", "musl", "musl_amd64"),
    bullseye_arm64 = _platform("linux", "arm64", "gnu.2.31", "bullseye_arm64", distro = "bullseye"),
    musl_arm64 = _platform("linux", "arm64", "musl", "musl_arm64"),
)

platforms_list = structs.to_dict(platforms).values()

# fallback_platforms are the "lowest denominators" that we still support. It is
# advisable to pick newer ones when the OS running the binaries is known to be
# newer, e.g., when building a container.
fallback_platforms = [
    platforms.jessie_amd64,
    platforms.bullseye_arm64,
]
