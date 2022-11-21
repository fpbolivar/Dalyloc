import 'package:daly_doc/utils/exportPackages.dart';

class SocialLoginManager {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );
  static GoogleSignInAccount? googleUser;
  late final GoogleSignInAuthentication? googleAuth;

  loginFaceBook(BuildContext context) async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        FacebookAccessToken? accessToken = res.accessToken;
        await LoginApis().googleFacebookLogin(
            accessToken: "${accessToken?.token}", type: "Facebook");

        print('Access token: ${accessToken?.token}');

        // Get profile data
        var profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! You ID: ${profile?.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  googleSignIn(BuildContext context) async {
    try {
      GoogleSignIn _googleSignIn =
          GoogleSignIn(scopes: <String>['email', 'profile']);
      _googleSignIn.signOut();
      googleUser = await _googleSignIn.signIn();

      googleAuth = await googleUser!.authentication;
      print(googleUser);
      var token = googleAuth!.accessToken;
      print(googleAuth!.accessToken);
      print(googleUser!.displayName);
      print(googleUser!.email);
      LoginApis().googleFacebookLogin(accessToken: token, type: "Google");
    } catch (error) {
      print(error);
    }
  }
}
