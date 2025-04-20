-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }



# Ignore missing classes to avoid warnings
-dontwarn com.google.android.play.core.**
-dontwarn com.google.android.play.core.tasks.**

# Keep your NotificationService class and all its methods
-keep class com.kaashier.pursenal.utils.services.NotificationService {
    *;
}

# Keep all Flutter plugin classes
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.app.** { *; }
-keep class com.dexterous.** { *; }