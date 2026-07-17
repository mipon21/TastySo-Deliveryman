# Flutter embedding & plugin registration (required for release/R8 builds)
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }

# JNI (path_provider_android 2.3.x)
-keep class com.github.dart_lang.jni.** { *; }

# Plugins with reflection / native Android code
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }
-keep class com.pravera.flutter_foreground_task.** { *; }
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keep class io.flutter.plugins.firebase.** { *; }
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class io.flutter.plugins.googlemaps.** { *; }
-keep class com.baseflow.geolocator.** { *; }
-keep class com.baseflow.geocoding.** { *; }
-keep class xyz.luan.audioplayers.** { *; }

# Flutter deferred components (Play Core) — not used by this app
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
