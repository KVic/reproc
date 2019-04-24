import qbs

Project {
    name: "reproc.tests"

    Project {
        name: "helpers"

        ReprocTestHelper { resourceName: "infinite" }
        ReprocTestHelper { resourceName: "noop"     }
        ReprocTestHelper { resourceName: "stderr"   }
        ReprocTestHelper { resourceName: "stdout"   }
    }

    ReprocTest {
        name      : "reproc-tests"
        targetName: "tests"

        sourcesFiles: [
            "read-write.cpp",
            "stop.cpp",
            "working-directory.cpp"
        ]

        // Force to install the tests into the qbs.installRoot in all OS
        // (instead of usr/local in the Linux)
        // to pass the "working-directory" test case.
        qbs.installPrefix: ""
    }
}
