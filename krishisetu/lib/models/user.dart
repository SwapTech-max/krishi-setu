import 'package:flutter/material.dart';

@immutable
class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.preferredLanguageCode,
    required this.primaryCrop,
    required this.district,
  });

  final String id;
  final String name;
  final String phone;
  final String preferredLanguageCode;
  final String primaryCrop;
  final String district;

  UserProfile copyWith({
    String? name,
    String? phone,
    String? preferredLanguageCode,
    String? primaryCrop,
    String? district,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      preferredLanguageCode: preferredLanguageCode ?? this.preferredLanguageCode,
      primaryCrop: primaryCrop ?? this.primaryCrop,
      district: district ?? this.district,
    );
  }
}

