import 'package:daly_doc/utils/exportPackages.dart';

class VideoProvider with ChangeNotifier {
  int duration = 0;
  int textDurationCounter = 0;
  int totalDuration = 0;
  double percentage = 0;
  initializeZero() {
    duration = 0;
    textDurationCounter = 0;
    totalDuration = 0;
    percentage = 0;
    notifyListeners();

    // setState(() {});
  }

  calculaterPercent() {
    percentage = (duration / totalDuration) * 100;
    percentage = percentage / 100;
    textDurationCounter = (totalDuration - duration).toInt();
    notifyListeners();

    // setState(() {});
  }
}
