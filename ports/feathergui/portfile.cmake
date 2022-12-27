
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Fundament-Software/feathergui
    REF 1014da40f38b53701d71eb253976c0130a97e8af
    SHA512 f560a512d93f72a9b0e7fe43f9c07d0a52540415a510006d9f9108abd372ebf76e7ddfaea4d58a76773704bdca97b68fa58d1c67d2010903216aabfb52072b4f
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS
        -DUSE_DEFAULT_FOLDERS=ON
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

#file(COPY ${CURRENT_PACKAGES_DIR}/lib/scopes DESTINATION ${CURRENT_PACKAGES_DIR}/tools/lib)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)