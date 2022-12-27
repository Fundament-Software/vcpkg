vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO innative-sdk/innative
    REF 16ab9e3a06a19eb690ec165f83a40c14ad966174
    SHA512 732b03517f56629a3ff0b8b0841851c46c51cd27e17fa624e8d77af5084828dbd51f96a1887d3e140336c00bf89d60c1abdc5944926b85dbdbb2e6cd34c044f4
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
vcpkg_copy_tools(TOOL_NAMES innative-cmd innative-test AUTO_CLEAN)
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/${PORT})

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/spec")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/spec")