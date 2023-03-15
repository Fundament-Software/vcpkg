if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    message(STATUS "Warning: Dynamic building not supported yet. Building static.")
    set(VCPKG_LIBRARY_LINKAGE static)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nodejs/uvwasi
    REF 02a7e485a50c61af7d79d4a55a4a2d042e5c1c1c
    SHA512 fff5817b0967f4649a7cf7e5748b47cc94122b4a3352f120ba545a7eee7ad4a6b4906a6c86a886b89f11469e50babdb6d14f5b6b20f34210134192b22fbbe94d
    HEAD_REF master
    PATCHES
        fix-install.patch
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/uvwasiConfig.cmake.in" DESTINATION "${SOURCE_PATH}")

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        tests UVWASI_BUILD_TESTS
        debug-log UVWASI_DEBUG_LOG
        code-coverage CODE_COVERAGE
        asan ASAN
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        ${FEATURE_OPTIONS}
        -DWITH_SYSTEM_LIBUV=ON
)

vcpkg_cmake_install()  
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup()
vcpkg_fixup_pkgconfig()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

file(INSTALL ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR} )
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
