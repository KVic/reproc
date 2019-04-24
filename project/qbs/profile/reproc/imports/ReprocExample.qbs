import qbs

ReprocBaseExample {
    Depends { name: "reproc.core" }

    cpp.cLanguageVersion: "c99"

    projectNamePrefix: "reproc"
    sourceFileSuffix : ".c"
}
