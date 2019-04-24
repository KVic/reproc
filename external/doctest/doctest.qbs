import qbs
import qbs.FileInfo

Product {
    Export {
        Depends { name: "cpp" }

        property path workingDirectory:
            FileInfo.joinPaths(qbs.installRoot, qbs.installPrefix, qbs.installDir)

        cpp.defines     : "DOCTEST_WORKING_DIRECTORY=\"" + workingDirectory + "\""
        cpp.includePaths: product.sourceDirectory

        Group {
            name : "Sources"
            files: ["main.cpp"]
        }
    }

    Group {
        name : "Headers"
        files: ["doctest.h"]
    }
}
