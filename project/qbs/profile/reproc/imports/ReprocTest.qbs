import qbs

CppApplication {
    Depends { name: "qbs" }
    Depends { name: "reproc.core" }
    Depends { name: "doctest" }

    property stringList sourcesFiles

    Group {
        name  : "Sources"
        prefix: sourceDirectory + "/tests/"
        files : sourcesFiles
    }

    Group {
        fileTagsFilter: "application"
        qbs.install   : true
    }
}
