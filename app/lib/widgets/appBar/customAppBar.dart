import '../../utils/exportPackages.dart';
import '../../utils/exportWidgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool icon;
  bool trailingIcon;
  Icon? trailingIconData;
  Function()? onTap;
  Function()? trailingIconOnTap;
  CustomAppBar(
      {super.key,
      this.trailingIconData,
      this.trailingIconOnTap,
      this.title = "",
      this.icon = true,
      this.onTap,
      this.trailingIcon = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon == true
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          // ignore: prefer_const_constructors
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (onTap == null) {
                              Navigator.of(context).pop();
                            } else {
                              onTap!();
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                              color: AppColor.textBlackColor),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            icon == false
                ? Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                          color: AppColor.textBlackColor),
                    ),
                  )
                : SizedBox(),
            trailingIcon == true
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: trailingIconData!,
                      onPressed: trailingIconOnTap,
                    ),
                  )
                : SizedBox(
                    width: 20,
                  ),
          ],
        ),
      ),
    );

    // AppBar(
    //     elevation: 0,
    //     title: Text(title),
    //     leading: IconButton(
    //       icon: Icon(
    //         Icons.arrow_back_ios,
    //         color: Colors.black,
    //       ),
    //       onPressed: () {},
    //     ),
    //     backgroundColor: Colors.transparent);
  }

  @override
  // TODO: implement preferredSize
  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}

class CustomAppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  String title = "";
  bool iconButton;
  CustomAppBarWithBackButton(
      {super.key, this.title = "", this.iconButton = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            iconButton == true
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  )
                : SizedBox(
                    width: 20,
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 0),
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: AppColor.textBlackColor),
              ),
            ),
          ],
        ),
      ),
    );

    // AppBar(
    //     elevation: 0,
    //     title: Text(title),
    //     leading: IconButton(
    //       icon: Icon(
    //         Icons.arrow_back_ios,
    //         color: Colors.black,
    //       ),
    //       onPressed: () {},
    //     ),
    //     backgroundColor: Colors.transparent);
  }

  @override
  // TODO: implement preferredSize
  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}

class CustomAppBarPresentCloseButton extends StatelessWidget
    implements PreferredSizeWidget {
  String title = "";
  String subtitle = "";
  double fontSize = 20;
  bool needShadow = true;
  double subfontSize = 25;
  double topPadding = 5;
  double topContainerPadding = 0;
  double topSubPadding = 5;
  Color? titleColor;
  Color? subtitleColor;
  Widget? rightWidget;
  CustomAppBarPresentCloseButton(
      {super.key,
      this.title = "",
      this.fontSize = 20,
      this.topContainerPadding = 0,
      this.subfontSize = 25,
      this.topPadding = 5,
      this.needShadow = true,
      this.topSubPadding = 0,
      this.subtitle = "",
      this.titleColor,
      this.rightWidget,
      this.subtitleColor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          color: AppColor.newBgcolor,
          boxShadow: needShadow == true
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(0.0, 2.5), //(x,y)
                    blurRadius: 1.0,
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 7),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, top: topContainerPadding),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: topPadding),
                        child: Text(
                          title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: fontSize,
                              color: titleColor ?? AppColor.theme),
                        ),
                      ),
                      if (subtitle != "")
                        Padding(
                          padding: EdgeInsets.only(top: topSubPadding),
                          child: Text(
                            " " + subtitle,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: subfontSize,
                                color: subtitleColor ?? AppColor.theme),
                          ),
                        ),
                    ],
                  )),
              Spacer(),
              if (rightWidget != null)
                Container(
                  child: rightWidget,
                )
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, top: 5),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.of(context).pop();
              //     },
              //     child: Image.asset(
              //       "assets/icons/ic_close.png",
              //       width: 25,
              //       height: 25,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );

    // AppBar(
    //     elevation: 0,
    //     title: Text(title),
    //     leading: IconButton(
    //       icon: Icon(
    //         Icons.arrow_back_ios,
    //         color: Colors.black,
    //       ),
    //       onPressed: () {},
    //     ),
    //     backgroundColor: Colors.transparent);
  }

  @override
  // TODO: implement preferredSize
  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
