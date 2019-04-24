import qbs

Project {
    qbsSearchPaths: ["project/qbs/profile/reproc"]

    references: [
        "reproc/reproc.core.qbs",
        "reproc/reproc.examples.qbs",
        "reproc/reproc.tests.qbs",
        "reproc++/reprocxx.core.qbs",
        "reproc++/reprocxx.examples.qbs",
        "external/doctest/doctest.qbs",
    ]
}
