import '../core/localStore/localStore.dart';
import '../utils/exportPackages.dart';

class FirebaseMessagingHelper {
  static var app = FirebaseMessagingHelper();
  void initializer() {
    // Set the background messaging handler early on, as a named top-level function
  }
  void setup() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    listenerMessaging();
    String? token = await FirebaseMessaging.instance.getAPNSToken();
    await LocalStore().setFCMToken(token ?? "");
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      await LocalStore().setFCMToken(token);
    });
  }

  void listenerMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage messgae) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(
      //   context,
      //   '/message',
      //   arguments: MessageArguments(message, true),
      // );
    });
  }
}
