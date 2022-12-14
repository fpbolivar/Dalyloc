import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import 'package:daly_doc/pages/mealPlan/model/receipeDetailModel.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class CarouselHeaderImagView extends StatelessWidget {
  String imgList = "";
  CarouselHeaderImagView({super.key, this.imgList = ""});

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
      backgroundColor: Colors.grey,
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
          fit: StackFit.expand,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        imgList,
                      ),
                      fit: BoxFit.cover)),
            )
            // CarouselSlider(
            //   items: imgList
            //       .map((item) => ClipRRect(
            //           borderRadius: BorderRadius.all(Radius.circular(0.0)),
            //           child: Image.network(item,
            //               fit: BoxFit.cover, width: 1200.0)))
            //       .toList(),
            //   carouselController: _controller,
            //   options: CarouselOptions(
            //       viewportFraction: 1,
            //       height: 200,
            //       autoPlay: true,
            //       enlargeCenterPage: false,
            //       aspectRatio: 100,
            //       onPageChanged: (index, reason) {
            //         // setState(() {
            //         //   _current = index;
            //         // });
            //       }),
            // ),
            ,
            Positioned(
              left: 0.0,
              top: 20,
              child: Container(width: 55, height: 55, child: blurButtonView()),
            ),
            Positioned(
              right: 0.0,
              top: 20,
              child: Container(width: 55, height: 55, child: homeButtonView()),
            ),

            // Positioned(
            //   bottom: 0.0,
            //   left: 0.0,
            //   right: 0.0,
            //   child: Container(
            //     decoration: BoxDecoration(),
            //     padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: imgList.asMap().entries.map((entry) {
            //         return GestureDetector(
            //           onTap: () => _controller.animateToPage(entry.key),
            //           child: Container(
            //             width: 5.0,
            //             height: 5.0,
            //             margin: EdgeInsets.symmetric(
            //                 vertical: 8.0, horizontal: 4.0),
            //             decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: _current == entry.key
            //                   ? AppColor.theme
            //                   : Colors.white,
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget blurButtonView() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.of(Constant.navigatorKey.currentState!.overlay!.context)
                .pop();
          },
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
    );
  }

  Widget homeButtonView() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Routes.gotoHomeScreen();
          },
          child: Container(
            width: 45.0,
            height: 45.0,
            decoration: BoxDecoration(
              color: AppColor.newBgcolor,
              //color: Colors.grey.shade700.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                "assets/icons/home.png",
                width: 25,
                height: 25,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
