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
      this.onClickCalendar})
      : super(key: key);
  Function(HeaderCalendarDatesModal)? onSelection;
  Function()? onClickCalendar;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width,
      color: AppColor.bgcolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              Spacer(),
              IconButton(
                autofocus: false,
                onPressed: () {
                  onClickCalendar!();
                },
                icon: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
              ),
              IconButton(
                autofocus: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
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
                      text: ("${headerDateList!.first.monthFormat}  ")
                          .toUpperCase(),
                      style: TextStyle(
                        color: AppColor.textWhiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      )),
                  TextSpan(
                      text: (headerDateList!.first.yyyyFormat ?? ""),
                      style: TextStyle(
                        color: AppColor.brownYearColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
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
                  color: AppColor.bgcolor,
                  child: Column(
                    children: [
                      Text(
                        item.dayFormat ?? "",
                        style: TextStyle(
                            fontSize: 17, color: AppColor.textWhiteColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          onSelection!(item);
                        },
                        child: Container(
                          decoration: selectedDate != null &&
                                  selectedDate!.dateTime == item.dateTime
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor
                                      .brownYearColor, // inner circle color
                                )
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.day ?? "",
                              style: TextStyle(
                                  fontSize: 15, color: AppColor.textWhiteColor),
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
