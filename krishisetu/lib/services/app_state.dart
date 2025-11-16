import 'package:flutter/material.dart';

import '../models/content.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/qna.dart';
import '../models/user.dart';
import 'mock_data_service.dart';

class AppState extends ChangeNotifier {
  final MockDataService _dataService = const MockDataService();

  bool _initialized = false;
  Locale _locale = const Locale('en');
  late UserProfile _user;
  late String _selectedCrop;
  late String _selectedDistrict;
  final List<Product> _cart = <Product>[];

  void initialize() {
    if (_initialized) {
      return;
    }
    _user = _dataService.defaultUser;
    _locale = Locale(_user.preferredLanguageCode);
    _selectedCrop = _user.primaryCrop;
    _selectedDistrict = _user.district;
    _initialized = true;
    notifyListeners();
  }

  Locale get locale => _locale;
  UserProfile get user => _user;
  String get selectedCrop => _selectedCrop;
  String get selectedDistrict => _selectedDistrict;
  List<Product> get cart => List<Product>.unmodifiable(_cart);

  List<String> get crops => _dataService.crops;
  List<String> get districts => _dataService.districts;

  List<Product> get products => _dataService.products;
  List<Product> get featuredProducts => _dataService.products.take(3).toList();

  List<Product> get aiRecommendations => _dataService.recommendationsFor(_selectedCrop, _selectedDistrict);

  List<Map<String, dynamic>> get partners => _dataService.partners;
  List<Order> get orders => _dataService.orders;
  List<QnaItem> get qnaItems => _dataService.qnaItems;
  List<LearningContent> get learningContent => _dataService.learnContent;

  void changeLocale(Locale locale) {
    if (locale == _locale) {
      return;
    }
    _locale = locale;
    _user = _user.copyWith(preferredLanguageCode: locale.languageCode);
    notifyListeners();
  }

  void updateCrop(String crop) {
    if (crop == _selectedCrop) {
      return;
    }
    _selectedCrop = crop;
    notifyListeners();
  }

  void updateDistrict(String district) {
    if (district == _selectedDistrict) {
      return;
    }
    _selectedDistrict = district;
    notifyListeners();
  }

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  void updateUserProfile(UserProfile updated) {
    _user = updated;
    notifyListeners();
  }
}

