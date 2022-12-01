import 'package:flutter/cupertino.dart';
import './../flutter_swipe_action_cell.dart';

class SwipeActionNavigatorObserver extends NavigatorObserver {
  final SwipeActionController _controller = SwipeActionController();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _controller.closeAllOpenCell();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _controller.closeAllOpenCell();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _controller.closeAllOpenCell();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _controller.closeAllOpenCell();
  }

  @override
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    _controller.closeAllOpenCell();
  }

  @override
  void didStopUserGesture() {
    _controller.closeAllOpenCell();
  }
}
