
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO innative-sdk/innative
    REF c0f1a8f06f3b27c6e19ed9076145fd1eea350c10
    SHA512 3c44d801390156444b3052f425df9aa765fb1342b95680ce8530fbf20f0a87dad327a4976d71253408068f318ec636c51fd22a29fbfb535272814cdd588b0d1e
    HEAD_REF master
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        use-mimalloc USE_MIMALLOC
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    WINDOWS_USE_MSBUILD
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS
        ${FEATURE_OPTIONS}
        -DUSE_DEFAULT_FOLDERS=ON
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()
vcpkg_copy_tools(TOOL_NAMES innative-cmd AUTO_CLEAN)
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/${PORT})

file(INSTALL ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
