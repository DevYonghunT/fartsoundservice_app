plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // Flutter Gradle 플러그인
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties
        import java.io.FileInputStream

// ----- keystore 연결(이미 설정돼 있다면 이 블록은 중복 없이 유지) -----
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.yourcompany.yourapp"                      // ← 기존 패키지명 유지!
    compileSdk = 34                                            // ← 프로젝트에 맞춰 유지/업데이트

    defaultConfig {
        applicationId = "com.yourcompany.yourapp"              // ← 기존과 동일해야 업데이트 가능
        minSdk = flutter.minSdkVersion                                            // ← 프로젝트 값 유지
        targetSdk = 34                                         // ← 프로젝트 값 유지
        versionCode = 2                                        // ← 이전보다 큰 정수
        versionName = "1.1.0"                                  // ← 표기용
        multiDexEnabled = true
    }

    // ----- 서명 설정(업로드 키) -----
    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    // ----- 핵심: 난독화/리소스 축소 켜기 → mapping.txt 생성 -----
    buildTypes {
        getByName("release") {
            // 릴리스 서명 사용
            signingConfig = signingConfigs.getByName("release")

            // ✅ mapping.txt 생성되도록 R8/ProGuard 활성화
            isMinifyEnabled = true
            isShrinkResources = true

            // ✅ R8 규칙 파일 연결(없으면 자동 생성/추가)
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            // 디버그 심볼이 필요하면(선택)
            // ndk { debugSymbolLevel = "FULL" }
        }

        // 디버그는 보통 난독화 끔
        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    // Kotlin 옵션/컴파일러 줄은 프로젝트 기본값 유지
    kotlinOptions {
        jvmTarget = "17"
        // freeCompilerArgs += listOf("-Xjvm-default=all")
    }

    // (필요 시) packagingOptions, compileOptions 등은 기존 설정 유지
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

// Flutter 소스 연결(템플릿 기본)
flutter {
    source = "../.."
}

// (필요 시) 종속성
dependencies {
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.appcompat:appcompat:1.7.0")
    implementation("com.google.android.material:material:1.12.0")
    // 기타 프로젝트 의존성 유지
}
