import 'package:aeye/asset/url.dart';
import "package:aeye/controller/sizeController.dart";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'profile',
  ],
  hostedDomain: '$HOST_URL/oauth2/authorization/google',
);

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.disconnect();
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        Map<String, String> headers = await _currentUser!.authHeaders;
        String? serverAuthCode = await _currentUser!.serverAuthCode;
        String? _idToken = await _currentUser!.id;
        _handleGetContact(_currentUser!);
        print("header");
        print(headers);
        print("serverauth");
        print(serverAuthCode);
        print("idtoken");
        print(_idToken);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
  }

  Future<void> _handleSignIn() async {
    try {
      dynamic googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        print("is not error");
        print(googleSignInAccount);
        return;
      }
    } catch (error) {
      print("is error");
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    GoogleSignInAccount? result1 = await _googleSignIn.signOut();
    print("please");
    print(result1);
    GoogleSignInAccount? result2 = await _googleSignIn.disconnect();
    print("nexta                                       ");
    print(result2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(
              top: scaleHeight(context, 30),
              left: scaleHeight(context, 20),
              right: scaleHeight(context, 20),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  child:
                      SizedBox(child: Image.asset("assets/images/logo.png"))),
              SizedBox(
                  child: IconButton(
                      onPressed: () async {
                        await _handleSignIn();
                      },
                      icon: Icon(Icons.add))),
              SizedBox(
                  child: IconButton(
                      onPressed: () async {
                        await _handleSignOut();
                      },
                      icon: Icon(Icons.exposure_minus_1)))
            ])));
  }
}
