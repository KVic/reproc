import qbs

CppApplication {
    name      : "reproc-resource-" + resourceName
    targetName: resourceName

    property string resourceName

    Depends { name: "cpp" }
    Depends { name: "qbs" }

    cpp.cxxLanguageVersion: "c++11"

    Group {
        name  : "Sources"
        prefix: sourceDirectory + "/resources/"
        files : [resourceName + ".cpp"]
    }

    Group {
        fileTagsFilter   : "application"
        qbs.installPrefix: "reproc"
        qbs.installDir   : "resources"
        qbs.install      : true
    }
}
