import '../../utils/exportPackages.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title = "";
  CustomAppBar({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        title: Text(title),
        backgroundColor: Color.fromARGB(164, 12, 4, 123));
  }

  @override
  // TODO: implement preferredSize
  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
