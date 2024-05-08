import 'package:get/get.dart';
import 'package:gold_price/locale/urdu.dart';
import 'english.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': english(),
        'urdu':urdu(),
      };
}
