
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Fundament-Software/scopes
    REF a8bfbf775a338ae2608a0cb7df816eb2272a6861
    SHA512 0422bc690a6aec757f4ce671723ded4ce5af89b7457a5bcb11e8f35a0d49111271a018a454e6017e01b230f3adba133912a7f12813784448ba2615a0a1fa01d8
    HEAD_REF master
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        enable-address-sanitizer USE_ASAN_UBSAN
        target-webassembly TARGET_WEBASSEMBLY
        target-aarch64 TARGET_AARCH64
        target-riscv TARGET_RISCV
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
vcpkg_copy_tools(TOOL_NAMES scopes AUTO_CLEAN)
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/${PORT})

file(COPY ${CURRENT_PACKAGES_DIR}/lib/scopes DESTINATION ${CURRENT_PACKAGES_DIR}/tools/lib)
file(INSTALL ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# On windows, we compile with clang-cl, which is incompatible with the lib check: https://github.com/microsoft/vcpkg/pull/10398
if(${TARGET_TRIPLET} MATCHES "x*-windows*")
  set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK enabled)
  set(VCPKG_POLICY_SKIP_DUMPBIN_CHECKS enabled)
endif()
