import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:todo/app/translations/en_US.dart';
import 'package:todo/app/translations/fa_IR.dart';

class LocalizationService extends Translations {
  // static final local = Locale('en', 'US');
  // static final fallBackLocale = Locale('en', 'US');

  // static final locales = [Locale('en', 'US'), Locale('fa', 'IR')];

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US':enUS,
    'fa_IR': faIR
  };
}
