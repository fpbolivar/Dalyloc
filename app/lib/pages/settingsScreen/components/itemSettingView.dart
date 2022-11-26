import 'package:flutter/cupertino.dart';

import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';
import '../model/SettingOption.dart';

class SettingItemView extends StatefulWidget {
  SettingItemView({super.key, this.itemData, this.onSelectionBool});
  SettingOption? itemData;
  Function(bool)? onSelectionBool;

  @override
  State<SettingItemView> createState() => _SettingItemViewState();
}

class _SettingItemViewState extends State<SettingItemView> {
  int _itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Row(
        children: [
          Text(
            widget.itemData!.type! == SettingType.counter
                ? "${_itemCount} ${widget.itemData?.title}"
                : "${widget.itemData?.title}",
            style: TextStyle(
                color: widget.itemData!.type! == SettingType.logout
                    ? Colors.red
                    : Colors.black,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          if (widget.itemData!.type! == SettingType.loading &&
              widget.itemData!.type! != SettingType.refresh)
            const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                )),
          if (widget.itemData!.type! == SettingType.counter)
            SizedBox(
                width: 110,
                height: 30,
                child: Transform.scale(
                  scale: .8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          if (_itemCount > 1) {
                            setState(() {
                              _itemCount--;
                            });
                          }
                        },
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColor.buttonColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0)),
                          ),
                          child: Center(
                              child: new Icon(
                            Icons.remove,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _itemCount++;
                          });
                        },
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColor.buttonColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ],
                  ),
                )),
          if (widget.itemData!.type! == SettingType.time)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SizedBox(
                  width: 50,
                  height: 20,
                  child: Transform.scale(
                      scale: 0.9,
                      child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.textBG,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "7:00 AM",
                            textAlign: TextAlign.center,
                          ))))),
            ),
          if (widget.itemData!.type! == SettingType.toggle)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Transform.scale(
                      scale: .7,
                      child: CupertinoSwitch(
                        trackColor: Colors.red, // **INACTIVE STATE COLOR**
                        activeColor: Colors.green, // **ACTIVE STATE COLOR**
                        value: widget.itemData!.value!,
                        onChanged: (bool value) {
                          widget.onSelectionBool!(value);
                        },
                      ))),
            ),
          if (widget.itemData!.type! != SettingType.logout &&
              widget.itemData!.type! != SettingType.loading &&
              widget.itemData!.type! != SettingType.refresh &&
              widget.itemData!.type! != SettingType.toggle &&
              widget.itemData!.type! != SettingType.counter &&
              widget.itemData!.type! != SettingType.time)
            Image.asset(
              'assets/icons/ic_arrow.png',
              fit: BoxFit.contain,
              height: 20,
              width: 20,
            ),
        ],
      ),
    );
  }
}
