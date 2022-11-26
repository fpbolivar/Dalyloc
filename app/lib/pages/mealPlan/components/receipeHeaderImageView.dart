import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import 'package:daly_doc/pages/mealPlan/model/receipeDetailModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class ReceipeHeaderImagView extends StatelessWidget {
  ReceipeDetailModel? data;
  ReceipeHeaderImagView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return bodyView(context);
  }

  bodyView(context) {
    return SliverAppBar(
      // this is where I would like to set some minimum constraint
      expandedHeight: 200,
      automaticallyImplyLeading: false,
      floating: false,
      pinned: false,

      bottom: const PreferredSize(
        // Add this code
        preferredSize: Size.fromHeight(60.0), // Add this code
        child: Text(''), // Add this code
      ), // Add this code
      flexibleSpace: Container(
        //   padding: const EdgeInsets.only(10),
        height: 200,
        width: double.infinity,
        // ignore: sort_child_properties_last
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withAlpha(0),
                    Colors.black12,
                    Colors.black
                  ],
                ),
              ),
            ),
            blurButtonView(),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                  data!.full_meal_image_url ?? "",
                ),
                fit: BoxFit.cover)),
      ),
    );
  }

  Widget blurButtonView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(Constant.navigatorKey.currentState!.overlay!.context)
              .pop();
        },
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              width: 45.0,
              height: 45.0,
              decoration: BoxDecoration(
                color: AppColor.newBgcolor,
                //color: Colors.grey.shade700.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
