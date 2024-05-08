import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:gold_price/services/notification_services.dart';
import '../models/response_models/gold_live_price_model.dart';


class HomeController extends GetxController {
  GoldLivePriceModel goldModel=GoldLivePriceModel();
  final goldPriceController = StreamController<GoldLivePriceModel>.broadcast();
  NotificationServices notificationServices=NotificationServices();
  @override
  void onInit() {
    super.onInit();
    subscribeTopic();
    Timer.periodic(Duration(seconds: 3), (timer) {
      getGoldPrice();
    });// Call the method to start fetching data
  }

  Future<void> getGoldPrice() async {
      try {
        final dio = Dio();
        final response = await dio.get('https://api.gold-api.com/price/XAU');
        goldModel = GoldLivePriceModel.fromJson(response.data);
        goldPriceController.sink.add(goldModel);
        notificationServices.isTokenRefresh();
      } catch (e, st) {
        print("Exception: $e, StackTrace: $st");
        goldPriceController.addError(e);
      }
  }

  void subscribeTopic()async{
    await FirebaseMessaging.instance.subscribeToTopic('saadGold');
  }


}
