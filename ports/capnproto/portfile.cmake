vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Fundament-Software/capnproto
    REF e55601583020fc09c2b10276823f3d327d260eb1
    SHA512 085046a3b59280863d53955a5cd64f08b62100973947bc50e50ca23587e6dc0b4ebc539bc6189c0f6935db7a7ab4a2abe03ea2231bb29cc3cf8436424adc712a
    HEAD_REF master
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        "openssl" OPENSSL_FEATURE
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
        "-DWITH_OPENSSL=${OPENSSL_FEATURE}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/CapnProto)

vcpkg_copy_tools(TOOL_NAMES capnp capnpc-c++ capnpc-capnp AUTO_CLEAN)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

vcpkg_fixup_pkgconfig()
