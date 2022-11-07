// import '../firebase/firebaseMessagingHelper.dart';
// import '../utils/exportAllModels.dart';
// import '../utils/exportPackages.dart';
// import '../utils/exportScreens.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);

//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   // PageController controller = PageController();
//   static final GoogleSignIn _googleSignIn = GoogleSignIn(
//     // Optional clientId
//     // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//     scopes: <String>[
//       'email',
//       'https://www.googleapis.com/auth/userinfo.profile',
//     ],
//   );
//   static GoogleSignInAccount? googleUser;
//   late final GoogleSignInAuthentication? googleAuth;
//   bool _isLoggedIn = false;
//   bool _isLoggedInf = false;
//   Map _userObj = {};
//   List<SliderModel> mySLides = <SliderModel>[];
//   int slideIndex = 0;
//   late PageController controller;

//   Widget _buildPageIndicator(bool isCurrentPage) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 2.0),
//       height: isCurrentPage ? 10.0 : 6.0,
//       width: isCurrentPage ? 10.0 : 6.0,
//       decoration: BoxDecoration(
//         color: isCurrentPage ? Colors.grey : Colors.grey[300],
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     mySLides = getSlides();
//     controller = new PageController();
//     FirebaseMessagingHelper().setup();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenW = MediaQuery.of(context).size.width;

//     return Container(
//       decoration: BoxDecoration(gradient: GradientColor.getGradient()),
//       child: Material(
//         // backgroundColor: Colors.white,
//         child: Container(
//           height: MediaQuery.of(context).size.height - 100,
//           child: Stack(
//             children: [
//               PageView(
//                 physics: NeverScrollableScrollPhysics(),
//                 controller: controller,
//                 onPageChanged: (index) {
//                   setState(() {
//                     slideIndex = index;
//                   });
//                 },
//                 children: [
//                   GetStartedScreen(
//                     imagePath: "assets/icons/dailydocnote.png",
//                     title: mySLides[0].getTitle(),
//                     desc: mySLides[0].getDesc(),
//                     ontap: () {
//                       controller.animateToPage(slideIndex + 1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.linear);
//                     },
//                   ),
//                   SocialLogin(
//                     onfacebook: () async {
                    
//                       // FacebookAuth.instance
//                       //     .getUserData()
//                       //     .then((userData) async {
//                       //   print(_userObj.entries);
//                       //   print(tokenAccess);
//                       //   await LoginApis().googleLogin(
//                       //       accessToken: tokenAccess, type: "Facebook");
//                       //   controller.animateToPage(slideIndex + 1,
//                       //       duration: Duration(milliseconds: 500),
//                       //       curve: Curves.linear);
//                       //   setState(() {
//                       //     _isLoggedIn = true;
//                       //     _userObj = userData;
//                       //   });
//                       // });
//                     },
//                     ongoogle: () async {
//                       googleUser = await _googleSignIn.signIn();
//                       googleAuth = await googleUser!.authentication;
//                       print(googleUser);
//                       var token = googleAuth!.accessToken;
//                       print(googleAuth!.accessToken);
//                       print(googleUser!.displayName);
//                       print(googleUser!.email);
//                       LoginApis()
//                           .googleLogin(accessToken: token, type: "Google");
//                       controller.animateToPage(slideIndex + 1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.linear);
//                     },
//                     ontapback: () {
//                       controller.animateToPage(slideIndex - 1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.linear);
//                     },
//                   ),
//                   ChooseAccountTypeScreen(
//                     ontapback: () {
//                       controller.animateToPage(slideIndex - 1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.linear);
//                     },
//                     imagePath: mySLides[1].getImageAssetPath(),
//                     title: mySLides[1].getTitle(),
//                     desc: mySLides[1].getDesc(),
//                     ontap: () {
//                       controller.animateToPage(slideIndex + 1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.linear);
//                     },
//                   ),
//                   wakeUpTime(
//                     ontapback: () {
//                       controller.animateToPage(slideIndex - 1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.linear);
//                     },
//                     imagePath: mySLides[2].getImageAssetPath(),
//                     ontap: () {
//                       controller.animateToPage(slideIndex + 1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.linear);
//                     },
//                   ),
//                   Reminder(
//                     ontapback: () {
//                       controller.animateToPage(slideIndex - 1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.linear);
//                     },
//                     imagePath: "assets/icons/bell.png",
//                     title: mySLides[3].getTitle(),
//                     desc: mySLides[3].getDesc(),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 30),
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                       child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 16),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         // TextButton(
//                         //   onPressed: () {},
//                         //   // splashColor: Colors.blue[50],
//                         //   child: Text(
//                         //     "SKIP",
//                         //     style: TextStyle(
//                         //         color: Colors.red,
//                         //         fontSize: screenW <= 500 ? 15 : 20,
//                         //         fontWeight: FontWeight.w600),
//                         //   ),
//                         // ),
//                         Container(
//                           child: Row(
//                             children: [
//                               for (int i = 0; i < 4; i++)
//                                 i == slideIndex
//                                     ? _buildPageIndicator(true)
//                                     : _buildPageIndicator(false),
//                             ],
//                           ),
//                         ),
//                         // TextButton(
//                         //   onPressed: () {},
//                         //   // splashColor: Colors.blue[50],
//                         //   child: Text(
//                         //     slideIndex != 3 ? "NEXT" : "START",
//                         //     style: TextStyle(
//                         //         color: Color(0xFFffffff),
//                         //         fontSize: screenW <= 500 ? 15 : 20,
//                         //         fontWeight: FontWeight.w600),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   )),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
