# Using Your Own Google Auth (Firebase) Credentials

The app uses **Firebase Auth** with **Google Sign-In**. Credentials come from config files, not from code. Replace the existing files with ones from your own Firebase project.

---

## 1. Create / use a Firebase project

1. Go to [Firebase Console](https://console.firebase.google.com/).
2. Create a new project (or select an existing one).
3. In **Build → Authentication**, enable the **Google** sign-in provider.

---

## 2. Android

1. In Firebase: **Project settings** (gear) → **Your apps** → **Add app** → **Android**.
2. Use your app’s **package name** (current in the project: `com.incodes.tingle`).  
   If you use a different package name, also update `applicationId` in `android/app/build.gradle` and the package in `AndroidManifest.xml`.
3. Download **`google-services.json`**.
4. **Replace** the existing file:
   - Put the new file at: **`android/app/google-services.json`**  
   (overwrite the current one).

No changes are required in Dart/Java for Android; the plugin reads this file automatically.

---

## 3. iOS

1. In Firebase: **Project settings** → **Your apps** → **Add app** → **iOS**.
2. Use your app’s **bundle ID** (current: `com.incodes.tingle`).  
   If you use a different bundle ID, update it in Xcode and in the Firebase iOS app config.
3. Download **`GoogleService-Info.plist`**.
4. **Replace** the existing file:
   - Put the new file at: **`ios/Runner/GoogleService-Info.plist`**  
   (overwrite the current one).
5. **Update the URL scheme for Google Sign-In**  
   Open **`ios/Runner/Info.plist`** and set the Google Sign-In URL scheme to the **REVERSED_CLIENT_ID** from your new `GoogleService-Info.plist`:
   - In `GoogleService-Info.plist`, find the key **`REVERSED_CLIENT_ID`** (value like `com.googleusercontent.apps.XXXXX-yyyy...`).
   - In `Info.plist`, under **CFBundleURLTypes** → **CFBundleURLSchemes**, replace the existing string with that **REVERSED_CLIENT_ID** value.

Example: if `REVERSED_CLIENT_ID` is `com.googleusercontent.apps.12345-abc.apps.googleusercontent.com`, then in `Info.plist` you should have:

```xml
<key>CFBundleURLSchemes</key>
<array>
  <string>com.googleusercontent.apps.12345-abc.apps.googleusercontent.com</string>
</array>
```

---

## 4. Backend (NestJS)

Your backend verifies the **Firebase ID token** sent by the app (e.g. in `POST /auth/login`). That verification must use the **same Firebase project** as the one in the new config files.

- If you use **Firebase Admin SDK**: (re)download the **service account key** (JSON) for the **new** project and point your backend to it (e.g. env var or path).
- If you use a **third-party JWT library**: verify the token’s `aud` / `iss` against the new project’s project ID and Firebase issuer.

After switching Firebase projects, existing users (Firebase UIDs) will be from the old project; you may need to re-register or migrate.

---

## 5. Optional: different app package / bundle ID

If your app uses a **different package name (Android)** or **bundle ID (iOS)**:

- **Android:** Register that package in the Firebase Android app and use the `google-services.json` for that app. Ensure `android/app/build.gradle` has the same `applicationId`.
- **iOS:** Register that bundle ID in the Firebase iOS app and use the `GoogleService-Info.plist` for that app. Ensure Xcode’s bundle identifier matches.

---

## Summary

| Platform | What to replace | Extra step |
|----------|------------------|------------|
| **Android** | `android/app/google-services.json` | — |
| **iOS**     | `ios/Runner/GoogleService-Info.plist` | Set `CFBundleURLSchemes` in `ios/Runner/Info.plist` to your new `REVERSED_CLIENT_ID` |
| **Backend** | Use the same Firebase project (and service account / project ID) for token verification | — |

No Dart code changes are required; replacing the config files and the iOS URL scheme is enough for the mobile app to use your Google Auth credentials.
