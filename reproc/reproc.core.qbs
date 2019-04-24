import qbs
import qbs.Environment

StaticLibrary {
    targetName: "reproc"

    Depends { name: "cpp" }

    cpp.cLanguageVersion: "c99"
    cpp.includePaths    : "include"

    Properties {
        condition: qbs.targetOS.contains("unix")

        cpp.dynamicLibraries: ["pthread"]
        cpp.defines: {
            // Needed for `pipe2` and `kill`.
            var defines = ["_GNU_SOURCE"];

            // TODO: Add a check that the 'pipe2' is available.
            // CMake: check_symbol_exists(pipe2 unistd.h REPROC_PIPE2_FOUND)
            // Now, the PIPE2_FOUND is defined
            // if the variable REPROC_PIPE2_FOUND
            // is defined in the build environment.
            if (Environment.getEnv("REPROC_PIPE2_FOUND") != undefined)
                defines.push("PIPE2_FOUND");

            return defines;
        }
    }

    Properties {
        condition: qbs.targetOS.contains("windows")

        cpp.defines: {
            // Remove unneeded stuff from windows.h.
            var defines = ["WIN32_LEAN_AND_MEAN", "VC_EXTRALEAN", "NOMINMAX"];

            // TODO: Add a check that the `STARTUPINFOEX`
            //       and functions related to it are available.
            // CMake: check_symbol_exists(InitializeProcThreadAttributeList
            //                            windows.h
            //                            REPROC_ATTRIBUTE_LIST_FOUND)
            // Now, the ATTRIBUTE_LIST_FOUND is defined
            // if the variable REPROC_ATTRIBUTE_LIST_FOUND
            // is defined in the build environment.
            if (Environment.getEnv("REPROC_ATTRIBUTE_LIST_FOUND") != undefined)
                defines.push("ATTRIBUTE_LIST_FOUND");

            return defines;
        }
    }

    Export {
        Depends { name: "cpp" }

        cpp.includePaths: "include"

        Properties {
            condition: qbs.targetOS.contains("unix")

            cpp.dynamicLibraries: ["pthread"]
        }
    }

    Group {
        name  : "Headers"
        prefix: "include/reproc/"
        files : [
            "error.h",
            "export.h",
            "reproc.h",
        ]
    }

    Group {
        name  : "Sources common"
        prefix: "src/common/"
        files : [
            "error.c",
            "infinite.c",
            "reproc.c",
        ]
    }

    Group {
        condition: qbs.targetOS.contains("unix")

        name  : "Sources POSIX"
        prefix: "src/posix/"
        files : [
            "error.c",
            "fd.c",
            "pipe.c",
            "process.c",
            "reproc.c",
        ]
    }

    Group {
        condition: qbs.targetOS.contains("windows")

        name  : "Sources Windows"
        prefix: "src/windows/"
        files : [
            "error.c",
            "handle.c",
            "pipe.c",
            "process.c",
            "reproc.c",
            "string_utils.c",
        ]
    }

    Group {
        fileTagsFilter: "dynamiclibrary"
        qbs.install   : true
    }
}
