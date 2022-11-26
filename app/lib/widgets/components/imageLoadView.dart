import 'package:cached_network_image/cached_network_image.dart';
import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/components/commonWidget.dart';

class ImageLoadView extends StatelessWidget {
  String? imgURL = "";
  bool isUserType = false;
  ImageLoadView({this.imgURL, this.isUserType = false});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imgURL!,
        placeholder: (context, url) => Center(
          child: Container(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.theme),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: !isUserType
              ? simpleMessageShow("Unable load image")
              : Image(
                  image: !isUserType
                      ? AssetImage("assets/images/icon-splash.png")
                      : AssetImage("assets/images/avatar.png"),
                  fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class ImageLoadViewWithoutClip extends StatelessWidget {
  String? imgURL = "";
  BoxFit fit;
  ImageLoadViewWithoutClip({this.imgURL, this.fit = BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: this.fit,
      imageUrl: imgURL!,
      placeholder: (context, url) => Center(
        child: Container(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.theme),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Text("No Image"),
      ),
    );
  }
}

class ImageLoadService extends StatelessWidget {
  String? imgURL = "";
  BoxFit fit;
  bool paddingTopEnable;
  ImageLoadService(
      {this.imgURL, this.fit = BoxFit.fill, this.paddingTopEnable = true});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: this.fit,
      imageUrl: imgURL!,
      placeholder: (context, url) => Center(
        child: Container(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.theme),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Padding(
          padding: EdgeInsets.only(top: paddingTopEnable ? 30 : 0),
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
      ),
    );
  }
}

class ImageLoadServiceAspectRatio extends StatelessWidget {
  String? imgURL = "";
  BoxFit fit;
  bool paddingTopEnable;
  ImageLoadServiceAspectRatio(
      {this.imgURL, this.fit = BoxFit.fill, this.paddingTopEnable = true});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: this.fit,
      imageUrl: imgURL!,
      placeholder: (context, url) => Center(
        child: Container(
          padding: EdgeInsets.all(12),
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.theme),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Padding(
          padding: EdgeInsets.only(top: paddingTopEnable ? 30 : 0),
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
      ),
    );
  }
}

class CirclurLoader extends StatelessWidget {
  Color color;
  CirclurLoader({this.color = Colors.white});
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 1.5,
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}

class ImageLoadFromURL extends StatelessWidget {
  String? imgURL = "";
  BoxFit fit;
  bool paddingTopEnable;
  ImageLoadFromURL(
      {this.imgURL, this.fit = BoxFit.fill, this.paddingTopEnable = false});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: this.fit,
      imageUrl: imgURL!,
      placeholder: (context, url) => Center(
        child: Container(
          //padding: EdgeInsets.all(12),
          // width: 30,
          // height: 30,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.theme),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Padding(
          padding: EdgeInsets.only(top: paddingTopEnable ? 30 : 0),
          child: Image.asset(
            "assets/icons/empty.jpeg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
