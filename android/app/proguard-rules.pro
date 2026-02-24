-keepclassmembers class ai.deepar.ar.DeepAR { *; } # Use => DeepAr
-keepclassmembers class ai.deepar.ar.core.videotexture.VideoTextureAndroidJava { *; } # Use => DeepAr
-keep class ai.deepar.ar.core.videotexture.VideoTextureAndroidJava # Use => DeepAr
  -keepclassmembers class * { # Use => DeepAr
    @android.webkit.JavascriptInterface <methods>; # Use => DeepAr
} # Use => DeepAr


# Suppress warnings for missing Stripe push provisioning classes

# Gujarati => app release mode ma run noti thati atle stream_pk_item_widget.dart.dart line add karvi padi je ahi thi start thai chhe
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider

# Suppress warnings for missing ProGuard annotation classes
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers

-keep class com.stripe.android.pushProvisioning.** { *; }
-keep class com.razorpay.AnalyticsEvent { *; }
-keepclassmembers class com.razorpay.AnalyticsEvent { *; }
# Gujarati => app release mode ma run noti thati atle stream_pk_item_widget.dart.dart line add karvi padi je ahi thi puri thai chhe