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
    print("FCMMM $token}");
    await LocalStore().setFCMToken(token ?? "");
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      print("FCMMM $token}");
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

/// Manages & returns the users FCM token.
///
/// Also monitors token refreshes and updates state.
class TokenMonitor extends StatefulWidget {
  // ignore: public_member_api_docs
  TokenMonitor(this._builder);

  final Widget Function(String? token) _builder;

  @override
  State<StatefulWidget> createState() => _TokenMonitor();
}

class _TokenMonitor extends State<TokenMonitor> {
  String? _token;
  late Stream<String> _tokenStream;

  void setToken(String? token) {
    print('FCM Token: $token');
    setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUsE1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA')
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(_token);
  }
}
