import "package:firebase_messaging/firebase_messaging.dart";
import "package:get/get.dart";

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  // 최신버전의 초기화 방법
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  Rx<RemoteMessage> remoteMessage = const RemoteMessage().obs;
  // remoteMessage 가 obx 에서 검출이 잘되지 않아서 dateTime 을 추가함
  Rx<DateTime> dateTime = DateTime.now().obs;

  Future<void> initializeLocalNotifications() async {
    _initNotification();
    // 토큰을 알면 특정 디바이스에게 문자를 전달가능
    _getToken();
  }

  void _getToken() async {
    _messaging.getToken().then((token) {});
  }

  void _initNotification() {
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      //background/terminate 상태에서 메세지 핸들링 관련
      return;
    });
    // 앱이 동작중일때 호출됨
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      _addNotification(event);
    });
    // 앱이 background 동작중일때 호출됨
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _addNotification(message);
    });
    // 앱이 terminated 상태일 때 호출됨
  }

  // 메시지를 변수에 저장
  void _addNotification(RemoteMessage event) {
    dateTime(event.sentTime);
    remoteMessage(event);
  }
}
