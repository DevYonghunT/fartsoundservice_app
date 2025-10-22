// 최상위 프로젝트 build.gradle.kts
// ⚙️ 여기서는 공통 저장소와 clean task 설정만 필요합니다.

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 📦 공통 빌드 경로 설정
// (선택사항 — 없애도 됨. 유지하려면 안전하게 이렇게.)
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    layout.buildDirectory.set(newSubprojectBuildDir)
    evaluationDependsOn(":app")
}

// 🧹 clean 명령어 등록
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
