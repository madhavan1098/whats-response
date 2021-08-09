import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/ui/screens/analytics/analytics_screen.dart';
import 'package:whatsauto/ui/screens/contact/contactpage.dart';
import 'package:whatsauto/ui/screens/more/more_screen.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/homeMainTextFiled.dart';

import 'homepage.dart';

class HomeMainScreen extends StatefulWidget {
  @override
  _HomeSectionScreenState createState() => _HomeSectionScreenState();
}

class _HomeSectionScreenState extends State<HomeMainScreen> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  int selectedIndex = 0;
  bool _canCheckBiometrics;
  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePageScreen(),
    ContactPageScreen(),
    AnalyticsScreen(),
    MoreScreen(),
    Container(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> onItemTapped(int index) async {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: Container(child: _widgetOptions.elementAt(selectedIndex))),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset('assets/images/svg/home.svg',
                height: 20, width: 20, color: MyColors.primaryColor),
            icon: SvgPicture.asset(
              'assets/images/svg/home.svg',
              height: 20,
              width: 20,
              color: Colors.blueGrey,
            ),
            title: Text(
              'Home',
              style: homeBottomAppBarTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset('assets/images/svg/contact-book.svg',
                height: 20, width: 20, color: MyColors.primaryColor),
            icon: SvgPicture.asset(
              'assets/images/svg/contact-book.svg',
              color: Colors.blueGrey,
              height: 20,
              width: 20,
            ),
            title: Text(
              'Contacts',
              style: homeBottomAppBarTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Stack(
              children: [
                SvgPicture.asset('assets/images/svg/pie-chart.svg',
                    height: 20, width: 20, color: MyColors.primaryColor),
              ],
            ),
            title: Text(
              'Analytics',
              style: homeBottomAppBarTextStyle,
            ),
            icon: Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/svg/pie-chart.svg',
                  height: 20,
                  width: 20,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset('assets/images/svg/dots.svg',
                height: 20, width: 20, color: MyColors.primaryColor),
            icon: SvgPicture.asset(
              'assets/images/svg/dots.svg',
              color: Colors.blueGrey,
              height: 20,
              width: 20,
            ),
            title: Text(
              'more',
              style: homeBottomAppBarTextStyle,
            ),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: MyColors.primaryColor,
        unselectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyColors.white,
        onTap: (index) {
          onItemTapped(index);
        },
      ),
    );
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      var isAllowed = value.getBool(Globals.SECURITY_ALLOWED);
      if (isAllowed == true) {
        _authenticateWithBiometrics();
      }
    });
    super.initState();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason:
              'Scan your fingerprint (or face or whatever) to authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      _authenticate();
      return;
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  @override
  void dispose() {
    _cancelAuthentication();
    super.dispose();
  }

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }
}
