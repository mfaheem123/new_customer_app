// Standard Flutter template layout: redirect Gradle output to <project>/build so the
// flutter tool finds build/app/outputs/flutter-apk/*.apk.
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    project.layout.buildDirectory.value(newBuildDir.dir(project.name))
}

// Some Flutter plugins (e.g. flutter_rotation_sensor) hardcode an older compileSdk than
// their own transitive AARs require. Force every Android subproject up to the app's
// compileSdk so checkDebugAarMetadata doesn't fail.
val forcedCompileSdk = 36

subprojects {
    afterEvaluate {
        val androidExt = project.extensions.findByName("android") ?: return@afterEvaluate
        val isIntParam = { t: Class<*> -> t == Int::class.javaPrimitiveType || t == Integer::class.java }

        val applied = androidExt.javaClass.methods
            .firstOrNull { it.name == "setCompileSdk" && it.parameterCount == 1 && isIntParam(it.parameterTypes[0]) }
            ?.let { runCatching { it.invoke(androidExt, forcedCompileSdk) }.isSuccess }
            ?: false

        if (!applied) {
            androidExt.javaClass.methods
                .firstOrNull { it.name == "compileSdkVersion" && it.parameterCount == 1 && isIntParam(it.parameterTypes[0]) }
                ?.let { runCatching { it.invoke(androidExt, forcedCompileSdk) } }
        }
    }
}

//plugins {
//    id("com.google.gms.google-services") version "4.4.2" apply false
//}
//
//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//val newBuildDir: Directory =
//    rootProject.layout.buildDirectory
//        .dir("../../build")
//        .get()
//rootProject.layout.buildDirectory.value(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//    project.layout.buildDirectory.value(newSubprojectBuildDir)
//}
//subprojects {
//    project.evaluationDependsOn(":app")
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}
