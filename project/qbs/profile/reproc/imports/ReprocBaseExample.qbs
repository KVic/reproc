import qbs

CppApplication {
    name      : projectNamePrefix + "-" + exampleName
    targetName: exampleName

    property string exampleName
    property string projectNamePrefix
    property string sourceFileSuffix

    Group {
        name  : "Sources"
        prefix: sourceDirectory + "/examples/"
        files : [exampleName + sourceFileSuffix]
    }

    Group {
        fileTagsFilter   : "application"
        qbs.installPrefix: projectNamePrefix + "/examples"
        qbs.install      : true
    }
}
