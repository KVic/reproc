import qbs

StaticLibrary {
    targetName: "reproc++"

    Depends { name: "reproc.core" }

    cpp.cxxLanguageVersion: "c++11"
    cpp.includePaths      : "include"

    Export {
        Depends { name: "cpp" }
        Depends { name: "reproc.core" }

        cpp.includePaths: "include"
    }

    Group {
        name  : "Headers"
        prefix: "include/reproc++/"
        files : [
            "error.hpp",
            "export.hpp",
            "reproc.hpp",
            "sink.hpp",
        ]
    }

    Group {
        name  : "Sources"
        prefix: "src/"
        files : [
            "error.cpp",
            "reproc.cpp",
            "sink.cpp",
        ]
    }

    Group {
        fileTagsFilter: "dynamiclibrary"
        qbs.install   : true
    }
}
