# Flutter's own wrapper classes are referenced via JNI and platform
# channels — never safe to rename/strip.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# google_mobile_ads and in_app_purchase both reflectively invoke methods
# on their Android SDK classes; over-aggressive shrinking has historically
# broken ad rendering and purchase callbacks on these plugins specifically.
-keep class com.google.android.gms.ads.** { *; }
-keep class com.android.billingclient.api.** { *; }

# sqflite opens the SQLite native bridge reflectively.
-keep class com.tekartik.sqflite.** { *; }
