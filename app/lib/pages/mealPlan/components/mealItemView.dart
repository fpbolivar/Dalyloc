import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';

class MealItemViewWidget extends StatelessWidget {
  MealItemModel? item;

  int categoryId;
  MealItemViewWidget({Key? key, this.item, this.categoryId = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: -4,
          )
        ],
      ),
      child: Card(
          margin: EdgeInsets.zero,
          // color: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: SizedBox(
              child: Stack(
            // alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image.asset(
                    //   "assets/icons/ic_dishes.png",
                    //   fit: BoxFit.cover,
                    //   // width: 60,
                    //   // height: 60,
                    // ),
                    ImageLoadFromURL(
                      fit: BoxFit.cover,
                      imgURL: item?.full_meal_image_url,
                    ),
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
                  ],
                ),
              ),
              //   if (item!.isVideo!)
              //     Positioned(
              //       left: 16,
              //       bottom: 16,
              //       right: 16,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             item!.leagueName.toString(),
              //             style: Theme.of(context).textTheme.headline3!.copyWith(
              //                 fontFamily: bold,
              //                 fontSize: 14,
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.w600),
              //           ),
              //           Column(
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     item!.matchName.toString(),
              //                     style: Theme.of(context)
              //                         .textTheme
              //                         .headline3!
              //                         .copyWith(
              //                             fontSize: 18,
              //                             color: Colors.white,
              //                             height: 1.5),
              //                   ),
              //                   Row(
              //                     children: [
              //                       // Image.network(
              //                       //   'https://upload.wikimedia.org/wikipedia/ar/f/f1/%D8%B4%D8%B9%D8%A7%D8%B1_%D8%A7%D9%84%D8%A7%D8%AA%D8%AD%D8%A7%D8%AF_%D8%A7%D9%84%D8%B3%D9%83%D9%86%D8%AF%D8%B1%D9%8A.png',
              //                       //   width: 26,
              //                       //   height: 26,
              //                       // ),

              //                       Image.asset(
              //                         Images.alAhlyLogo,
              //                         width: 30,
              //                         height: 30,
              //                       ),
              //                       Image.asset(
              //                         Images.alAhlyLogo2,
              //                         width: 30,
              //                         height: 30,
              //                       ),
              //                     ],
              //                   )
              //                 ],
              //               )
              //             ],
              //           )
              //         ],
              //       ),
              //     )
            ],
          ))),
    );
  }
}
