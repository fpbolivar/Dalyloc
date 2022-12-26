import 'package:daly_doc/utils/exportWidgets.dart';

import '../../utils/exportPackages.dart';
import 'headerCalendarModel.dart';

class HeaderCalendar extends StatelessWidget {
  List<HeaderCalendarDatesModal>? headerDateList = [];
  HeaderCalendarDatesModal? selectedDate;

  HeaderCalendar(
      {Key? key,
      this.headerDateList,
      this.onSelection,
      this.selectedDate,
      this.onClickCalendar,
      this.onClickDrawer,
      this.onClickSetting,
      this.onClickNotification})
      : super(key: key);
  Function(HeaderCalendarDatesModal)? onSelection;
  Function()? onClickCalendar;
  Function()? onClickSetting;
  Function()? onClickNotification;
  Function()? onClickDrawer;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(selectedDate!.monthFormat ?? "");
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width,
      color: AppColor.newBgcolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // IconButton(
              //     onPressed: () {
              //       Navigator.pop(
              //         context,
              //       );
              //     },
              //     icon: const Icon(
              //       Icons.arrow_back_ios,
              //       color: Colors.black,
              //     )),
              IconButton(
                onPressed: () {
                  onClickDrawer!();
                },
                icon: Image.asset(
                  "assets/icons/menu.png",
                  width: 20,
                  height: 20,
                ),
              ),
              Spacer(),
              IconButton(
                autofocus: false,
                onPressed: () {
                  onClickCalendar!();
                },
                icon: Image.asset(
                  "assets/icons/ic_calendar.png",
                  width: 20,
                  height: 20,
                ),
              ),
              IconButton(
                autofocus: false,
                onPressed: () {
                  onClickNotification!();
                },
                icon: Image.asset(
                  "assets/icons/ic_bell_notification.png",
                  width: 20,
                  height: 20,
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     onClickSetting!();
              //   },
              //   icon: Image.asset(
              //     "assets/icons/ic_setting.png",
              //     width: 20,
              //     height: 20,
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 36),
                children: <TextSpan>[
                  TextSpan(
                      text: ("${selectedDate!.monthFormat ?? ""}  "),
                      style: TextStyle(
                        color: AppColor.textBlackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                      )),
                  TextSpan(
                      text: (selectedDate!.yyyyFormat ?? ""),
                      style: TextStyle(
                        color: AppColor.textGrayBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 70,
            child: ListView.separated(
              itemCount:
                  headerDateList!.length > 7 ? 7 : headerDateList!.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = headerDateList![index];
                var countSize =
                    headerDateList!.length > 7 ? 7 : headerDateList!.length;
                return Container(
                  width: (MediaQuery.of(context).size.width / countSize) - 10,
                  height: 50,
                  color: AppColor.newBgcolor,
                  child: Column(
                    children: [
                      Text(
                        item.dayFormat ?? "",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.textGrayBlue),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          print(item.dateTime);
                          onSelection!(item);
                        },
                        child: Container(
                          decoration: selectedDate != null &&
                                  selectedDate!.dateTime == item.dateTime
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor
                                      .buttonColor, // inner circle color
                                )
                              : BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor
                                      .halfBlueGray, // inner circle color
                                ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              item.day ?? "",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: (selectedDate != null &&
                                          selectedDate!.dateTime ==
                                              item.dateTime)
                                      ? AppColor.textWhiteColor
                                      : AppColor.buttonColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 5,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
