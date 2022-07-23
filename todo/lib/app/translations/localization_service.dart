import 'package:get/get.dart';
import 'package:todo/app/translations/en_US.dart';
import 'package:todo/app/translations/fa_IR.dart';

class LocalizationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'fa_IR': faIR};
}
