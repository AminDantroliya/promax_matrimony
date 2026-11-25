# 📱 Pro Matrimony — App Cloning & Dynamic Theming Guide

[![Flutter](https://img.shields.io/badge/Flutter-3.8+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Config-3--Layer%20Architecture-2E7D32?style=for-the-badge)](file:///Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony/lib/config/app_config.dart)
[![Dynamic Theming](https://img.shields.io/badge/Theming-100%25%20Dynamic-EA5575?style=for-the-badge)](file:///Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony/lib/app_theme/app_theme.dart)
[![License](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-455A64?style=for-the-badge)](https://flutter.dev)

> **Why Clone Instead of Multi-Tenant White-Labeling?**  
> Cloning the codebase gives you **100% full code freedom** for each client. Every client gets their own dedicated Git repository, independent build pipeline, isolated Firebase/Zego keys, and custom business logic without multi-tenant maintenance baggage.

---

## 📑 Quick Navigation

1. [🏛️ The 3-Tier Configuration Architecture](#️-the-3-tier-configuration-architecture)
2. [🌐 Backend Dynamic API Contract (`getTokenApi`)](#-backend-dynamic-api-contract-gettokenapi)
3. [🎛️ Complete Dynamic Flags Reference Catalog](#️-complete-dynamic-flags-reference-catalog)
   - [Layout & Screen Design Variants](#1-layout--screen-design-variants)
   - [Brand Colors & Gradients](#2-brand-colors--gradients)
   - [Typography & Google Fonts](#3-typography--font-family)
   - [Widget & Component Styling](#4-widget--component-styling)
   - [Feature Toggles (Enable / Disable)](#5-feature-toggles-functionality)
4. [🚀 10-Step App Cloning Walkthrough](#-10-step-app-cloning-walkthrough)
   - [Step 1: Duplicate Codebase & Clean Cache](#step-1-duplicate-codebase--clean-cache)
   - [Step 2: Configure Environment Credentials (`.env`)](#step-2-configure-environment-credentials-env)
   - [Step 3: Rebrand Android (Package Name & App Title)](#step-3-rebrand-android-package-name--app-title)
   - [Step 4: Rebrand iOS (Bundle ID & Display Name)](#step-4-rebrand-ios-bundle-id--display-name)
   - [Step 5: Setup Offline Fallbacks in `flavor_config.dart`](#step-5-setup-offline-fallbacks-in-flavor_configdart)
   - [Step 6: Replace App Icons & Logo Assets](#step-6-replace-app-icons--logo-assets)
   - [Step 7: Add Client Firebase Project Files](#step-7-add-client-firebase-project-files)
   - [Step 8: Configure Zego Cloud Offline Push Calling](#step-8-configure-zego-cloud-offline-push-calling)
   - [Step 9: Configure Payment Gateways](#step-9-configure-payment-gateways)
   - [Step 10: Launch & Verify Dynamic Theming](#step-10-launch--verify-dynamic-theming)
5. [✅ Pre-Launch Verification Checklist](#-pre-launch-verification-checklist)

---

## 🏛️ The 3-Tier Configuration Architecture

The app uses a 3-layer configuration pipeline so the admin panel can update layouts, brand colors, typography, and features **on the fly without re-submitting to the App Store or Play Store**:

```
┌─────────────────────────────────────────────────────────────┐
│ LAYER 1: FlavorConfig (Compile-Time / Offline Fallbacks)    │
│ Location: lib/config/flavors/flavor_config.dart             │
│ • Reads BASE_URL from .env file                             │
│ • Provides instant offline defaults before first API call   │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ LAYER 2: RemoteConfig (Backend API Response)                │
│ Endpoint: "common-request/get-token" (getTokenApi)          │
│ • Admin changes to colors, screen styles & feature toggles  │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ LAYER 3: AppConfig (Single Merged Source of Truth)          │
│ Location: lib/config/app_config.dart                        │
│ • Combines RemoteConfig OVER FlavorConfig                   │
│ • Watched by Riverpod: ref.watch(appConfigProvider)         │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ REACTIVE UI & THEMES                                        │
│ • themeProvider & appThemeDataProvider (ThemeData)          │
│ • FigmaColors.primary(context) & AppCommonBackground        │
│ • Dynamic screen routers & featureProvider('enableChat')    │
└─────────────────────────────────────────────────────────────┘
```

### Core Configuration Files

| File | Purpose | When to Modify |
| :--- | :--- | :--- |
| [`lib/config/flavors/flavor_config.dart`](file:///Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony/lib/config/flavors/flavor_config.dart) | **Compile-Time Defaults**<br>App name, fallback colors, initial offline screen styles. | Edit **ONCE** per cloned client. |
| [`lib/config/app_config.dart`](file:///Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony/lib/config/app_config.dart) | **Merged Config Model**<br>Parses backend API responses and merges them over flavor fallbacks. | Rarely touched unless adding brand new flags. |
| [`lib/app_theme/theme_provider.dart`](file:///Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony/lib/app_theme/theme_provider.dart) | **Theme Notifier & State**<br>Controls light/dark/system mode and reactive rebuilds. | Fully automated. |
| [`lib/app_theme/app_theme.dart`](file:///Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony/lib/app_theme/app_theme.dart) | **Design System & Tokens**<br>Generates `ThemeData`, normalizes Google Fonts, and defines `FigmaColors`. | Fully automated. |

---

## 🌐 Backend Dynamic API Contract (`getTokenApi`)

On app cold start, the app calls `getTokenApi` (`getAppConfigApi`):
- **Endpoint**: `common-request/get-token`
- **Method**: `POST`
- **Request Payload**:
  ```json
  {
    "app_version": "1.0.0",
    "device_type": "android"
  }
  ```

### Example Admin Response Payload:
```json
{
  "status": "success",
  "message": "Token generated successfully",
  "data": {
    "app_name": "XYZ Matrimony",
    "logo_url": "https://api.clientxyz.com/assets/logo.png",

    "dashboard_design": "design_3",
    "other_profile_design": "design_1",
    "profile_card_style": "design_1",
    "privacy_settings_design": "design_1",
    "my_profile_design": "design_1",
    "is_match_swipable_profile": true,
    "member_list_design": "grid",
    "register_design": "section_wise",
    "profile_design": "expandable",
    "login_design": "modern",
    "onboarding_style": "slides",
    "text_field_design": "outlined",
    "tab_bar_design": "standard",

    "font_family": "PlusJakartaSans",

    "primary_color": "#EA5575",
    "secondary_color": "#E8798F",
    "gradient_start": "#EA5575",
    "gradient_end": "#E8798F",
    "scaffold_bg_color": "#FEF7F3",

    "theme_mode": "system",
    "border_radius": 20.0,
    "button_style": "rounded",

    "default_country_code": "+91",
    "default_country_iso": "IN",
    "default_country_flag": "🇮🇳",
    "default_language_code": "en",
    "max_photos_allowed": 4,

    "support_whatsapp": "+919876543210",
    "support_phone": "+919876543210",
    "support_email": "support@xyzmatrimony.com",
    "website_url": "https://xyzmatrimony.com",

    "enable_chat": true,
    "enable_video_call": true,
    "enable_voice_call": true,
    "show_premium_badge": true,
    "show_astro_match": true,
    "enable_notifications": true,
    "enable_referral": false,
    "enable_meeting": true,
    "enable_success_stories": true,
    "enable_admin_matches": true,
    "enable_advanced_search": true,

    "enable_membership_plans": true,
    "enable_international_members": true,

    "enable_aadhaar_verification": true,
    "enable_identity_verification": true,
    "enable_selfie_verification": true,

    "enable_ai_matchmaking": true,
    "show_ai_hero_banner": true,
    "enable_ai_bio_generator": true,

    "enable_photo_privacy": true,
    "enable_photo_request": true,
    "enable_screenshot_protection": true,
    "enable_watermark_photos": false,

    "enable_horoscope": true,
    "enable_biodata_download": true,

    "enable_otp_login": true,
    "enable_password_login": true,
    "enable_social_login": true,
    "enable_guest_browsing": false,

    "enable_shortlist": true,
    "enable_block_profile": true,
    "enable_report_profile": true,
    "enable_contact_view": true,
    "enable_interest_reminders": true,

    "enable_dark_mode": true,
    "enable_multi_language": true,

    "is_maintenance_mode": false,
    "maintenance_msg_key": "maintenance_message"
  }
}
```

> [!NOTE]
> **Plan Currency Handling**: Membership plan currency symbols (`₹`, `$`, `AED`, `£`, etc.) are delivered **dynamically from the backend plan API response** per package (`item.currencyCode ?? item.planCurrency`). This ensures full multi-currency flexibility across international plans without requiring a hardcoded currency flag.

---

## 🎛️ Complete Dynamic Flags Reference Catalog

### 1. Unified Layout & Screen Design Variants

All multi-design modules follow a **unified standard naming pattern**: `design_1`, `design_2`, `design_3`, `design_4`, etc.

> [!TIP]
> **Dynamic Incremental IDs**: The frontend parsing engine uses a dynamic numeric extractor (`RegExp(r'(\d+)')`). If you add a new design on the backend (e.g. `design_6`), the app extracts the ID dynamically. Legacy aliases (`dashboard_3`, `card_1`, `design1`, `1`) remain 100% backward-compatible.

| Module | Flag Key | Unified Values | Legacy Aliases | What It Controls in the App |
| :--- | :--- | :--- | :--- | :--- |
| **Home Dashboard** | `dashboard_design` | `"design_1"`, `"design_2"`, `"design_3"` | `"dashboard_1"`, `"dashboard_2"`, `"dashboard_3"` | Switches between Classic Hero (`design_1`), Modern Circular Progress (`design_2`), and Luxury Greeting with Quick Stats (`design_3`). |
| **Other Member Profile** | `other_profile_design` | `"design_1"` to `"design_5"` | `"design1"` to `"design5"` | Selects between Expandable Accordions (`design_1`), Modern Hero Header (`design_2`), Tabbed Overview (`design_3`), or Immersive Photo layouts (`design_4`, `design_5`). |
| **Profile Card Style** | `profile_card_style` | `"design_1"` to `"design_6"` | `"card_1"` to `"card_6"` | Controls the visual layout of member cards across search results, matches feed, and activity lists. |
| **Privacy Settings** | `privacy_settings_design` | `"design_1"`, `"design_2"` | `"design1"`, `"design2"` | Grouped card layout (`design_1`) vs. modern segmented toggle list (`design_2`). |
| **My Profile Screen** | `my_profile_design` | `"design_1"`, `"design_2"` | `"design1"`, `"design2"` | Quick-action profile list (`design_1`) vs. gradient header with completeness progress (`design_2`). |
| **Matches Mode** | `is_match_swipable_profile` | `true`, `false` | `is_swipable_match` | `true` = Tinder-like swipe deck (`DatingCardSwiper`).<br>`false` = Standard grid/list match cards. |
| **Member List Mode** | `member_list_design` | `"grid"`, `"list"` | — | Initial layout mode in search & matches before user toggles. |
| **Registration Flow** | `register_design` | `"section_wise"` | — | Dynamic multi-step registration wizard driven by backend form schema. |
| **Login Screen** | `login_design` | `"modern"` | — | Modern tabbed OTP/Password authentication screen. |
| **Onboarding Style** | `onboarding_style` | `"slides"` | — | Animated introductory walkthrough presentation. |
| **Text Fields** | `text_field_design` | `"outlined"` | — | Form inputs decoration style. |
| **Tab Bar Style** | `tab_bar_design` | `"standard"` | — | Navigation tab bar visual variant. |

---

### 2. Regional Defaults, Media Limits & Support Contacts

| Flag Key | Type | Default | Example | Description |
| :--- | :---: | :---: | :---: | :--- |
| `default_country_code` | `String` | `"+91"` | `"+91"`, `"+1"` | Pre-selected country dial code in Login & Registration. |
| `default_country_iso` | `String` | `"IN"` | `"IN"`, `"US"` | 2-letter ISO code for phone fields and validation. |
| `default_country_flag` | `String` | `"🇮🇳"` | `"🇮🇳"`, `"🇺🇸"` | Flag emoji displayed in phone inputs. |
| `default_language_code` | `String` | `"en"` | `"en"`, `"hi"`, `"gu"` | Initial app language before user preference is saved. |
| `max_photos_allowed` | `int` | `4` | `4`, `6` | Maximum number of photos a user is allowed to upload in Manage Photos. |
| `support_whatsapp` | `String` | — | `"+919876543210"` | Direct click-to-chat WhatsApp button in Help & Support. |
| `support_phone` | `String` | — | `"+919876543210"` | One-tap phone calling support contact. |
| `support_email` | `String` | — | `"support@app.com"` | Direct mailto support contact. |
| `website_url` | `String` | — | `"https://app.com"` | Official website link shown in Drawer / About. |

---

### 3. Brand Colors & Gradients

| Flag Key | Type | Example | UI Impact & Affected Components |
| :--- | :---: | :---: | :--- |
| `primary_color` | `String` (Hex) | `"#EA5575"` | **Main Brand Accent**<br>Sets `ThemeData.primaryColor`, `colorScheme.primary`, primary buttons, app bar accents, and `FigmaColors.primary(context)`. |
| `secondary_color` | `String` (Hex) | `"#E8798F"` | **Secondary / Accent Color**<br>Sets `ThemeData.colorScheme.secondary`, badge tints, pill backgrounds, and `FigmaColors.secondary(context)`. |
| `gradient_start` | `String` (Hex) | `"#EA5575"` | **Gradient Start (Left/Top)**<br>Used in `AppConfig.primaryGradient` for buttons and banners. |
| `gradient_end` | `String` (Hex) | `"#E8798F"` | **Gradient End (Right/Bottom)**<br>Used in `AppConfig.primaryGradient` for buttons and banners. |
| `scaffold_bg_color` | `String` (Hex) | `"#FEF7F3"` | **Page Background Color**<br>Injected into `ThemeData.scaffoldBackgroundColor` and rendered dynamically by `AppCommonBackground`. Automatically switches to `#1B0527` in dark mode. |

---

### 4. Typography (`font_family`)

| Flag Key | Type | Example Values | Resolution & How It Works |
| :--- | :---: | :---: | :--- |
| `font_family` | `String` | `"PlusJakartaSans"`<br>`"Inter"`<br>`"Roboto"`<br>`"Poppins"` | **Dynamic Google Fonts Integration**<br>• Supports any valid Google Font name.<br>• Font names sent without spaces (e.g. `"PlusJakartaSans"`) are **automatically normalized** to `"Plus Jakarta Sans"`.<br>• If network is offline, it safely falls back to local assets (`Inter`). |

---

### 5. Widget & Component Styling

| Flag Key | Type | Default | Options | What It Does |
| :--- | :---: | :---: | :---: | :--- |
| `theme_mode` | `String` | `"system"` | `system`<br>`light`<br>`dark` | Sets the initial theme mode for new users before they choose light/dark in Settings. Persisted via Riverpod `themeProvider`. |
| `border_radius` | `double` | `20.0` | Any double | Controls corner rounding across `CardThemeData.shape`, dialogs, and cards. |
| `button_style` | `String` | `"rounded"` | `rounded`<br>`sharp` | `rounded` = 50px pill buttons (`AppPrimaryButton`).<br>`sharp` = 5px modern rectangular buttons. |

---

### 6. Categorized Feature Toggles

#### A. Communication & Calling
| Flag Key | Default | When `true` | When `false` |
| :--- | :---: | :--- | :--- |
| `enable_chat` | `true` | In-app 1-on-1 messaging enabled; Chat tab visible. | Chat tab & messaging routes completely hidden. |
| `enable_video_call` | `true` | Zego Cloud video calling button shown in profile & chat. | Video calling button hidden. |
| `enable_voice_call` | `true` | Zego Cloud audio calling button shown in profile & chat. | Voice calling button hidden. |

#### B. Monetization & Plans
| Flag Key | Default | When `true` | When `false` |
| :--- | :---: | :--- | :--- |
| `enable_membership_plans` | `true` | Membership upgrade cards, plan comparison, and payment flows active. | Subscription cards & upgrade triggers hidden. |
| `enable_international_members` | `true` | International NRI/foreign profiles shown in match search. | Restricts member search to domestic country. |
| `show_premium_badge` | `true` | VIP badge displayed on paid profiles. | Paid badges omitted. |

#### C. Verification & Trust
| Flag Key | Default | When `true` | When `false` |
| :--- | :---: | :--- | :--- |
| `enable_aadhaar_verification` | `true` | Aadhaar OTP verification available for Indian profiles. | Aadhaar verification options hidden. |
| `enable_identity_verification` | `true` | Government ID upload tab visible in Manage Photos. | ID upload tab hidden. |
| `enable_selfie_verification` | `true` | Live camera selfie verification flow active. | Selfie verification omitted. |

#### D. AI Matchmaking & Tools
| Flag Key | Default | When `true` | When `false` |
| :--- | :---: | :--- | :--- |
| `enable_ai_matchmaking` | `true` | AI match recommendation cards & filter screens active. | AI matchmaking cards hidden. |
| `show_ai_hero_banner` | `true` | Large AI hero card rendered on Dashboard 3. | AI hero banner hidden. |
| `enable_ai_bio_generator` | `true` | AI bio generator assistant active during profile edit. | AI bio generator hidden. |

#### E. Privacy & Security
| Flag Key | Default | When `true` | When `false` |
| :--- | :---: | :--- | :--- |
| `enable_photo_privacy` | `true` | Photo lock with password/request permissions enabled. | All photos visible publicly. |
| `enable_photo_request` | `true` | "Request Photo" button shown for private profiles; Photo Request menu item shown. | Photo requests disabled. |
| `enable_screenshot_protection` | `true` | Prevents screen recording & screenshots on sensitive screens. | Screenshot protection disabled. |
| `enable_watermark_photos` | `false` | Overlays matri-id watermark over member photos. | Photos displayed clean. |

#### F. Culture & Compatibility
| Flag Key | Default | When `true` | When `false` |
| :--- | :---: | :--- | :--- |
| `enable_horoscope` | `true` | Kundali / Horoscope tab shown in Manage Photos and member profile. | Horoscope tab completely hidden. |
| `show_astro_match` | `true` | Astrological Guna match score displayed on profiles. | Astro match scores omitted. |
| `enable_biodata_download` | `true` | "Download PDF Biodata" button available on profiles. | Biodata download button hidden. |

#### G. Auth & Access
| Flag Key | Default | When `true` | When `false` |
| :--- | :---: | :--- | :--- |
| `enable_otp_login` | `true` | SMS/WhatsApp OTP login tab active. | OTP login tab hidden. |
| `enable_password_login` | `true` | Password authentication option active. | Password login tab hidden. |
| `enable_social_login` | `true` | Google / Apple sign-in buttons displayed. | Social login options hidden. |
| `enable_guest_browsing` | `false` | Allows browsing public profiles without logging in. | Must login to view any profile. |

#### H. Discovery & Interactions
| Flag Key | Default | When `true` | When `false` |
| :--- | :---: | :--- | :--- |
| `enable_shortlist` | `true` | Shortlist heart button on cards & "Shortlisted" menu active. | Shortlisting disabled. |
| `enable_block_profile` | `true` | Block profile option & "Blocked Members" menu active. | Block feature hidden. |
| `enable_report_profile` | `true` | Report member flag option shown in profile popup menu. | Report option hidden. |
| `enable_contact_view` | `true` | "View Contact" button shown with phone number unlock. | Direct contact view disabled. |
| `enable_interest_reminders` | `true` | Push notifications to follow up on pending interests. | Reminders omitted. |
| `enable_notifications` | `true` | Notification bell in dashboard header active. | Bell icon hidden. |
| `enable_meeting` | `true` | Manager meeting scheduler active in More menu. | Meeting scheduler hidden. |
| `enable_success_stories` | `true` | Success Stories hub active in More menu. | Success stories section hidden. |
| `enable_admin_matches` | `true` | Admin Handpicked Matches tab displayed in Matches hub. | Admin Matches tab hidden. |
| `enable_advanced_search` | `true` | Advanced Search tab available in Search screen. | Advanced Search tab hidden. |
| `enable_referral` | `false` | Referral sharing & wallet rewards enabled. | Referral features hidden. |

#### I. Settings & Localization
| Flag Key | Default | When `true` | When `false` |
| :--- | :---: | :--- | :--- |
| `enable_dark_mode` | `true` | Dark mode toggle active in Settings. | App locked to light theme. |
| `enable_multi_language` | `true` | Language selection sheet active in Settings. | Language selector hidden. |

---

## 🚀 10-Step App Cloning Walkthrough

Follow these 10 sequential steps when setting up a new client app (e.g. base project `pro_matrimony` &rarr; client project **"XYZ Matrimony"**, package `com.clientxyz.matrimony`).

---

### Step 1: Duplicate Codebase & Clean Cache

1. Copy the project folder to your new client directory:
   ```bash
   cp -R pro_matrimony client_xyz_matrimony
   cd client_xyz_matrimony
   ```
2. Reset Git history for the new client:
   ```bash
   rm -rf .git
   git init
   ```
3. Remove old build artifacts and caches:
   ```bash
   flutter clean
   rm -rf .idea .dart_tool build
   ```

---

### Step 2: Configure Environment Credentials (`.env`)

Open `.env` (or `.env.prod`) and replace with the client's API URL and 3rd-party keys:

```env
# Client API Domain
BASE_URL=https://api.clientxyz.com/api/
ENABLE_LOGGING=true
ENV_NAME=PROD

# Zego Cloud Credentials (Audio/Video Calls)
ZEGO_APP_ID=123456789
ZEGO_APP_SIGN=a1b2c3d4e5f67890abcdef1234567890abcdef1234567890abcdef1234567890

# Optional Payment Credentials (Client Specific)
PAYPAL_CLIENT_ID=clientxyz_paypal_client_id
PAYPAL_CLIENT_SECRET=clientxyz_paypal_secret
PAYPAL_MODE=live
PAYPAL_BASE_URL=https://api-m.paypal.com

PHONEPE_MERCHANT_ID=CLIENTXYZ_MERCHANT
PHONEPE_CLIENT_ID=clientxyz_phonepe_id
PHONEPE_CLIENT_SECRET=clientxyz_phonepe_secret
PHONEPE_BASE_URL=https://api.phonepe.com/
```

---

### Step 3: Rebrand Android (Package Name & App Title)

#### A. Update Application ID & Namespace:
Open [`android/app/build.gradle`](file:///Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony/android/app/build.gradle):
```groovy
android {
    namespace = "com.clientxyz.matrimony" // <--- Change namespace

    defaultConfig {
        applicationId = "com.clientxyz.matrimony" // <--- Change Application ID
        ...
    }
}
```

#### B. Update Launcher App Title:
Open [`android/app/src/main/AndroidManifest.xml`](file:///Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony/android/app/src/main/AndroidManifest.xml):
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.clientxyz.matrimony">

    <application
        android:label="XYZ Matrimony" <!-- <--- Client App Name on Home Screen -->
        ... >
```

#### C. Move `MainActivity.kt` to Matching Folder:
1. Create directory structure:  
   `android/app/src/main/kotlin/com/clientxyz/matrimony/`
2. Move `MainActivity.kt` into this folder.
3. Update line 1 of `MainActivity.kt`:
   ```kotlin
   package com.clientxyz.matrimony
   ```

---

### Step 4: Rebrand iOS (Bundle ID & Display Name)

1. Open the iOS project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```
2. Select **Runner** (top-left) &rarr; Click **Runner** under Targets.
3. In the **General** tab:
   - **Display Name**: `XYZ Matrimony`
   - **Bundle Identifier**: `com.clientxyz.matrimony`
4. In the **Signing & Capabilities** tab:
   - Select your client's Apple Developer Team.

---

### Step 5: Setup Offline Fallbacks in `flavor_config.dart`

Open [`lib/config/flavors/flavor_config.dart`](file:///Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony/lib/config/flavors/flavor_config.dart) and update `FlavorConfig.defaultFlavor()` with the client's compile-time fallbacks:

```dart
factory FlavorConfig.defaultFlavor() => FlavorConfig(
  flavorName: 'default',
  baseUrl: EnvConfig.baseUrl, // Automatically pulls BASE_URL from .env!
  playStoreUrl: 'https://play.google.com/store/apps/details?id=com.clientxyz.matrimony',
  appStoreUrl: 'https://apps.apple.com/us/app/xyz-matrimony/id9999999999',
  themeDefaults: const FlavorThemeDefaults(
    appName: 'XYZ Matrimony',
    primaryColor: Color(0xFFEA5575),
    accentColor: Color(0xFFE8798F),
    gradientStart: Color(0xFFEA5575),
    gradientEnd: Color(0xFFE8798F),
    scaffoldBgColor: Color(0xFFFEF7F3),
    fontFamily: 'PlusJakartaSans',
    borderRadius: 20.0,
    buttonStyle: 'rounded',
    profileCardStyle: 'card_1',
    memberListDesign: 'grid',
    registerDesign: 'section_wise',
    profileDesign: 'expandable',
    dashboardDesign: 'dashboard_3',
    loginDesign: 'modern',
    textFieldDesign: 'outlined',
    tabBarDesign: 'standard',
    privacySettingsDesign: 'design_1',
  ),
  featureDefaults: const {
    'enableChat': true,
    'enableVideoCall': true,
    'enableVoiceCall': true,
    'showPremiumBadge': true,
    'showAstroMatch': true,
    'enableNotifications': true,
    'enableReferral': false,
    'enableMeeting': true,
    'enableSuccessStories': true,
    'enableAdminMatches': true,
    'enableAdvancedSearch': true,
  },
);
```

---

### Step 6: Replace App Icons & Logo Assets

1. **Android App Launcher Icons**:
   - Replace files in `android/app/src/main/res/mipmap-*/ic_launcher.png`
2. **iOS App Launcher Icons**:
   - In Xcode, replace icons in `ios/Runner/Assets.xcassets/AppIcon.appiconset`
3. **In-App Logos & Graphics**:
   - Replace logo and splash assets inside `assets/png/images/` and `assets/svg_icons/`

---

### Step 7: Add Client Firebase Project Files

1. Open [Firebase Console](https://console.firebase.google.com/) and create a project for the client.
2. Add **Android App** (`com.clientxyz.matrimony`):
   - Download `google-services.json` &rarr; Place into `android/app/google-services.json`.
3. Add **iOS App** (`com.clientxyz.matrimony`):
   - Download `GoogleService-Info.plist` &rarr; Place into `ios/Runner/GoogleService-Info.plist`.

---

### Step 8: Configure Zego Cloud Offline Push Calling

To ensure 1-on-1 audio/video calls ring even when the phone screen is locked or the app is terminated:

1. In [Zego Cloud Console](https://console.zegocloud.com/dashboard), open your project.
2. Under **Notification Configuration**:
   - **Android**: Add Firebase Server Key & FCM credentials.
   - **iOS**: Upload `.p8` Apple Push Notification certificate matching `com.clientxyz.matrimony`.
3. Create Resource ID:
   - **Resource ID**: `zegouikit_call`
   - **Data Messages**: `Enabled`

---

### Step 9: Configure Payment Gateways

- **In-App Purchases**: Add matching product IDs in Google Play Console and App Store Connect.
- **PayPal / PhonePe**: Ensure callback webhook URLs point to the client's API domain.

---

### Step 10: Launch & Verify Dynamic Theming

Fetch dependencies and start the app:

```bash
flutter pub get
flutter run
```

1. **Inspect Token API**: Verify that `common-request/get-token` returns `HTTP 200` with the client's colors and layout flags.
2. **Test Theme Switch**: Change `primary_color` or `dashboard_design` in the admin panel and re-launch the app — verify that the layout and branding update without rebuilding!

---

## ✅ Pre-Launch Verification Checklist

```markdown
- [ ] .env has client BASE_URL, ZEGO_APP_ID, and ZEGO_APP_SIGN.
- [ ] android/app/build.gradle has updated applicationId and namespace.
- [ ] android/app/src/main/AndroidManifest.xml has updated android:label.
- [ ] MainActivity.kt moved to matching folder and package header updated.
- [ ] iOS Bundle Identifier and Display Name updated in Xcode.
- [ ] FlavorConfig.defaultFlavor() updated with client defaults in flavor_config.dart. 
- [ ] Android launcher icons (res/mipmap-*) & iOS AppIcon.appiconset replaced.
- [ ] Client Firebase google-services.json & GoogleService-Info.plist placed.
- [ ] Zego Cloud offline push configured with Resource ID "zegouikit_call".
- [ ] Backend API endpoint "common-request/get-token" active and returning valid JSON.
- [ ] Ran "flutter clean", "flutter pub get", and "flutter analyze" with 0 compilation errors.
```


Run Below Command Sonar Qube Test :-
./sonar-scanner-8.1.0.6389-macosx-x64/bin/sonar-scanner \
  -Dsonar.token=6a1b93633154bc34a8ede1fb14e753ae53333b04 \
  -Dsonar.organization=narjisinfotech \
  -Dsonar.projectKey=narjisinfotech_pro-max-matrimony \
  -Dsonar.host.url=https://sonarcloud.io \
  -Dsonar.sources=lib \
  -Dsonar.exclusions="sonar-scanner-*/**" \
  -Dsonar.coverage.exclusions="lib/**" \
  -Dsonar.cpd.exclusions="lib/**"

