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

# Flutter's engine optionally references Google Play Core's dynamic
# feature delivery ("deferred components") APIs
# (io.flutter.embedding.engine.deferredcomponents.PlayStoreDeferredComponentManager),
# but this app never uses deferred components, so the play-core library
# was never added as a dependency. R8 fails on these references purely
# because it can't verify classes it can't find — not because anything
# is actually broken. This is a known, currently-open Flutter engine
# issue (flutter/flutter#165646); -dontwarn is the documented workaround
# until Flutter's own build tooling resolves it upstream.
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
