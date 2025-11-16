import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    final localization = Localizations.of<AppLocalizations>(context, AppLocalizations);
    assert(localization != null, 'AppLocalizations not found in context');
    return localization!;
  }

  static const supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final localeName = Intl.canonicalizedLocale(locale.toLanguageTag());
    Intl.defaultLocale = localeName;
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  String currency(num value) {
    final regionLocale = Intl.canonicalizedLocale('${locale.languageCode}_IN');
    final formatter = NumberFormat.currency(locale: regionLocale, symbol: '₹');
    return formatter.format(value);
  }

  String get appTitle => Intl.message('KrishiSetu', name: 'appTitle', desc: 'Application title');
  String get home => Intl.message('Home', name: 'home', desc: 'Home navigation title');
  String get buy => Intl.message('Buy', name: 'buy', desc: 'Buy navigation title');
  String get ask => Intl.message('Ask', name: 'ask', desc: 'Ask navigation title');
  String get learn => Intl.message('Learn', name: 'learn', desc: 'Learn navigation title');
  String get account => Intl.message('Account', name: 'account', desc: 'Account navigation title');
  String get searchInputsHint => Intl.message('Search for seeds, fertilizer, tools…', name: 'searchInputsHint');
  String get cropLabel => Intl.message('Crop', name: 'cropLabel');
  String get districtLabel => Intl.message('District', name: 'districtLabel');
  String get aiRecommendationTitle => Intl.message('AI Product Recommendations', name: 'aiRecommendationTitle');
  String get featuredProductsTitle => Intl.message('Featured Products', name: 'featuredProductsTitle');
  String get seeAll => Intl.message('See all', name: 'seeAll');
  String get voiceSearchTooltip => Intl.message('Ask with your voice', name: 'voiceSearchTooltip');
  String get voiceSearchComingSoon => Intl.message('Voice search is coming soon.', name: 'voiceSearchComingSoon');
  String get buyScreenTitle => Intl.message('Shop Agri Inputs', name: 'buyScreenTitle');
  String get filterByCategory => Intl.message('Filter by category', name: 'filterByCategory');
  String get sortBy => Intl.message('Sort by', name: 'sortBy');
  String get sortLowToHigh => Intl.message('Price: Low to High', name: 'sortLowToHigh');
  String get sortHighToLow => Intl.message('Price: High to Low', name: 'sortHighToLow');
  String get sortBestRated => Intl.message('Best rated', name: 'sortBestRated');
  String get addToCart => Intl.message('Add to cart', name: 'addToCart');
  String get viewDetails => Intl.message('View details', name: 'viewDetails');
  String get productDetails => Intl.message('Product Details', name: 'productDetails');
  String get productDescription => Intl.message('Description', name: 'productDescription');
  String get reviews => Intl.message('Reviews', name: 'reviews');
  String get priceLabel => Intl.message('Price', name: 'priceLabel');
  String get ratingLabel => Intl.message('Rating', name: 'ratingLabel');
  String get askAnExpertTitle => Intl.message('Ask an Expert', name: 'askAnExpertTitle');
  String get askQuestionHeadline => Intl.message('Ask questions to agronomists and experts.', name: 'askQuestionHeadline');
  String get questionTitleLabel => Intl.message('Question title', name: 'questionTitleLabel');
  String get questionDescriptionLabel => Intl.message('Describe your question', name: 'questionDescriptionLabel');
  String get submitQuestion => Intl.message('Submit question', name: 'submitQuestion');
  String get fieldRequired => Intl.message('This field is required', name: 'fieldRequired');
  String get recentlyAnswered => Intl.message('Recently Answered', name: 'recentlyAnswered');
  String get chatPlaceholderTitle => Intl.message('Live Chat', name: 'chatPlaceholderTitle');
  String get chatPlaceholderSubtitle => Intl.message('Realtime expert chat coming soon.', name: 'chatPlaceholderSubtitle');
  String get learnTitle => Intl.message('Learn New Skills', name: 'learnTitle');
  String get learnSearchHint => Intl.message('Search guides or videos', name: 'learnSearchHint');
  String get noContentFound => Intl.message('No content found.', name: 'noContentFound');
  String get accountTitle => Intl.message('My Account', name: 'accountTitle');
  String get profileSectionTitle => Intl.message('Profile', name: 'profileSectionTitle');
  String get editProfile => Intl.message('Edit profile', name: 'editProfile');
  String get saveChanges => Intl.message('Save changes', name: 'saveChanges');
  String get userNameLabel => Intl.message('Name', name: 'userNameLabel');
  String get phoneLabel => Intl.message('Phone number', name: 'phoneLabel');
  String get preferredLanguage => Intl.message('Preferred language', name: 'preferredLanguage');
  String get primaryCrop => Intl.message('Primary crop', name: 'primaryCrop');
  String get primaryDistrict => Intl.message('District', name: 'primaryDistrict');
  String get myOrders => Intl.message('My Orders', name: 'myOrders');
  String get orderNumber => Intl.message('Order', name: 'orderNumber');
  String get statusLabel => Intl.message('Status', name: 'statusLabel');
  String get viewOrderDetails => Intl.message('View details', name: 'viewOrderDetails');
  String get logout => Intl.message('Logout', name: 'logout');
  String get languageSwitchHint => Intl.message('Switch to Hindi', name: 'languageSwitchHint');
  String get languageSwitchHintHi => Intl.message('Switch to English', name: 'languageSwitchHintHi');
  String get aiSummaryTitle => Intl.message('AI Summary', name: 'aiSummaryTitle');
  String get cropRecommendations => Intl.message('Crop Recommendations', name: 'cropRecommendations');
  String get farmersConnected => Intl.message('farmers connected', name: 'farmersConnected');
  String get addToCartSuccess => Intl.message('Added to cart', name: 'addToCartSuccess');
  String get recommendationAction => Intl.message('View in store', name: 'recommendationAction');
  String get homeHeroTitle => Intl.message('Trusted Agri Marketplace', name: 'homeHeroTitle');
  String get homeHeroSubtitle => Intl.message(
        'Genuine inputs, agronomy advice, and financing all in one platform.',
        name: 'homeHeroSubtitle',
      );
  String get categoryAll => Intl.message('All', name: 'categoryAll');
  String get categorySeeds => Intl.message('Seeds', name: 'categorySeeds');
  String get categoryFertilizer => Intl.message('Fertilizers', name: 'categoryFertilizer');
  String get categoryPesticide => Intl.message('Pesticides', name: 'categoryPesticide');
  String get categoryMachinery => Intl.message('Machinery', name: 'categoryMachinery');
  String get categoryServices => Intl.message('Services', name: 'categoryServices');
  String get homePartnersTitle => Intl.message('Trusted Partners', name: 'homePartnersTitle');
  String get discoverMore => Intl.message('Discover more', name: 'discoverMore');
  String get askSuccessMessage => Intl.message('Your question has been submitted.', name: 'askSuccessMessage');
  String get recommendationSubtitle => Intl.message('Tailored by crop, district, and weather signals.', name: 'recommendationSubtitle');
  String get homeWelcomeTitle => Intl.message('Welcome to KrishiSetu!', name: 'homeWelcomeTitle');
  String get homeWelcomeSubtitle => Intl.message(
        'Genuine inputs, best price, delivered to your farm.',
        name: 'homeWelcomeSubtitle',
      );
  String get homeIntroTitle => Intl.message(
        'KrishiSetu – Your complete farming companion',
        name: 'homeIntroTitle',
      );
  String get homeIntroBody => Intl.message(
        'One platform for every need – from seeds to market. Bridging the gap between traditional wisdom and modern farming solutions.',
        name: 'homeIntroBody',
      );
  String get quickActionStore => Intl.message('Krishi SuperStore', name: 'quickActionStore');
  String get quickActionExpert => Intl.message('Ask Expert', name: 'quickActionExpert');
  String get quickActionOrders => Intl.message('My Orders', name: 'quickActionOrders');
  String get quickActionFpo => Intl.message('FPO Connect', name: 'quickActionFpo');
  String get quickActionComingSoon => Intl.message('Coming soon', name: 'quickActionComingSoon');
  String get somethingWentWrong => Intl.message('Something went wrong. Please try again.', name: 'somethingWentWrong');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (supported) => supported.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

