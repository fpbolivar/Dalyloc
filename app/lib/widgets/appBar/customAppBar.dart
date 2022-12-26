import '../../utils/exportPackages.dart';
import '../../utils/exportWidgets.dart';
import '../carousel/carousel_slider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool icon;
  bool? needHomeIcon;
  bool trailingIcon;
  bool needLoader;
  Icon? trailingIconData;
  double fontSize = 20;
  MainAxisAlignment mainAxisAlignment;
  Function()? onTap;
  Function()? trailingIconOnTap;
  CustomAppBar(
      {super.key,
      this.needLoader = false,
      this.needHomeIcon = true,
      this.trailingIconData,
      this.trailingIconOnTap,
      this.fontSize = 23,
      this.title = "",
      this.icon = true,
      this.onTap,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.trailingIcon = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon == true
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 3),
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
                        padding: const EdgeInsets.only(left: 0),
                        child: needLoader
                            ? SizedBox(
                                width: 15, height: 15, child: loaderList())
                            : Text(
                                title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: fontSize,
                                    color: AppColor.textBlackColor),
                              ),
                      ),
                    ],
                  )
                : SizedBox(),
            icon == false
                ? Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: fontSize,
                          color: AppColor.textBlackColor),
                    ),
                  )
                : SizedBox(),
            if (trailingIcon) Spacer(),
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
            if (needHomeIcon! && !trailingIcon) Spacer(),
            if (needHomeIcon!) HomeButton()
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

class CustomAppBarWithImageScroll extends StatelessWidget
    implements PreferredSizeWidget {
  Widget? child;
  CustomAppBarWithImageScroll({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
            Container(padding: const EdgeInsets.only(top: 20), child: child));

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
  bool? needHomeIcon;
  double fontSize = 20;
  CustomAppBarWithBackButton({
    super.key,
    this.title = "",
    this.fontSize = 20,
    this.iconButton = true,
    this.needHomeIcon = true,
  });

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
                    fontSize: fontSize,
                    color: AppColor.textBlackColor),
              ),
            ),
            if (needHomeIcon!) Spacer(),
            if (needHomeIcon!) HomeButton()
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
  double homeIconTopPadding = 0;
  Color? titleColor;
  Color? subtitleColor;
  Color? colorNavBar;
  Widget? rightWidget;
  bool? needHomeIcon = true;

  CustomAppBarPresentCloseButton(
      {super.key,
      this.title = "",
      this.fontSize = 20,
      this.homeIconTopPadding = 0,
      this.colorNavBar,
      this.topContainerPadding = 0,
      this.subfontSize = 25,
      this.needHomeIcon = true,
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
          color: colorNavBar ?? AppColor.newBgcolor,
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
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                Row(
                  children: [
                    Container(
                      child: rightWidget,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (needHomeIcon!)
                      Padding(
                        padding: EdgeInsets.only(top: homeIconTopPadding),
                        child: HomeButton(),
                      )
                  ],
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
              ,
              if (rightWidget == null)
                if (needHomeIcon!)
                  Padding(
                    padding: EdgeInsets.only(top: homeIconTopPadding),
                    child: HomeButton(),
                  )
              //   Row(
              //     children: [Spacer(), HomeButton()],
              //   )
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

Widget HomeButton() {
  return InkWell(
    onTap: () {
      Routes.gotoHomeScreen();
    },
    child: Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Image.asset(
        "assets/icons/home.png",
        width: 25,
        height: 25,
      ),
    ),
  );
}
