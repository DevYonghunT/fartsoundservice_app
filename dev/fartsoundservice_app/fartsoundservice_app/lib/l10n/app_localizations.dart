import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko')
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Fart Playground'**
  String get app_title;

  /// No description provided for @initial_message.
  ///
  /// In en, this message translates to:
  /// **'Tap the button to play a random fart!'**
  String get initial_message;

  /// No description provided for @initial_bottom_message.
  ///
  /// In en, this message translates to:
  /// **'Haptics and sound ready.'**
  String get initial_bottom_message;

  /// No description provided for @button_text_1.
  ///
  /// In en, this message translates to:
  /// **'Let it go'**
  String get button_text_1;

  /// No description provided for @button_text_2.
  ///
  /// In en, this message translates to:
  /// **'One more!'**
  String get button_text_2;

  /// No description provided for @button_text_3.
  ///
  /// In en, this message translates to:
  /// **'Fire in the hole'**
  String get button_text_3;

  /// No description provided for @button_text_4.
  ///
  /// In en, this message translates to:
  /// **'Oops'**
  String get button_text_4;

  /// No description provided for @button_text_5.
  ///
  /// In en, this message translates to:
  /// **'Pffff'**
  String get button_text_5;

  /// No description provided for @button_text_6.
  ///
  /// In en, this message translates to:
  /// **'Hit me'**
  String get button_text_6;

  /// No description provided for @button_text_7.
  ///
  /// In en, this message translates to:
  /// **'Boost it'**
  String get button_text_7;

  /// No description provided for @button_text_8.
  ///
  /// In en, this message translates to:
  /// **'Again!'**
  String get button_text_8;

  /// No description provided for @button_text_9.
  ///
  /// In en, this message translates to:
  /// **'Do it'**
  String get button_text_9;

  /// No description provided for @button_text_10.
  ///
  /// In en, this message translates to:
  /// **'Push'**
  String get button_text_10;

  /// No description provided for @bottom_msg_1.
  ///
  /// In en, this message translates to:
  /// **'Low wind warning.'**
  String get bottom_msg_1;

  /// No description provided for @bottom_msg_2.
  ///
  /// In en, this message translates to:
  /// **'Breezy vibes.'**
  String get bottom_msg_2;

  /// No description provided for @bottom_msg_3.
  ///
  /// In en, this message translates to:
  /// **'Silent but deadly.'**
  String get bottom_msg_3;

  /// No description provided for @bottom_msg_4.
  ///
  /// In en, this message translates to:
  /// **'Air pressure rising.'**
  String get bottom_msg_4;

  /// No description provided for @bottom_msg_5.
  ///
  /// In en, this message translates to:
  /// **'Safety off.'**
  String get bottom_msg_5;

  /// No description provided for @bottom_msg_6.
  ///
  /// In en, this message translates to:
  /// **'Smell ya later.'**
  String get bottom_msg_6;

  /// No description provided for @bottom_msg_7.
  ///
  /// In en, this message translates to:
  /// **'Wind tunnel engaged.'**
  String get bottom_msg_7;

  /// No description provided for @bottom_msg_8.
  ///
  /// In en, this message translates to:
  /// **'Keep tapping.'**
  String get bottom_msg_8;

  /// No description provided for @bottom_msg_9.
  ///
  /// In en, this message translates to:
  /// **'Almost there.'**
  String get bottom_msg_9;

  /// No description provided for @bottom_msg_10.
  ///
  /// In en, this message translates to:
  /// **'Achievement unlocked.'**
  String get bottom_msg_10;

  /// No description provided for @sound_selector_auto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get sound_selector_auto;

  /// No description provided for @sound_selector_fart.
  ///
  /// In en, this message translates to:
  /// **'Fart '**
  String get sound_selector_fart;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
