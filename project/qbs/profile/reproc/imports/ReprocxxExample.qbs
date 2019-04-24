import qbs

ReprocBaseExample {
    Depends { name: "reprocxx.core" }

    cpp.cxxLanguageVersion: "c++11"

    projectNamePrefix: "reproc++"
    sourceFileSuffix : ".cpp"
}
