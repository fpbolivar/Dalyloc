import '../../utils/exportPackages.dart';
import '../../utils/exportWidgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title = "";
  CustomAppBar({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(
              height: 10,
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
  CustomAppBarWithBackButton({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
  Color? titleColor;
  Color? subtitleColor;
  CustomAppBarPresentCloseButton(
      {super.key,
      this.title = "",
      this.fontSize = 20,
      this.subtitle = "",
      this.titleColor,
      this.subtitleColor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          color: AppColor.newBgcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(0.0, 2.5), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
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
                        Text(
                          " " + subtitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: subtitleColor ?? AppColor.theme),
                        ),
                    ],
                  )),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    "assets/icons/ic_close.png",
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
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
