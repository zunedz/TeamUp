import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:orbital_login/services/firebaseAuth.dart';
import 'package:orbital_login/widgets/feeds/feed_part.dart';
import 'package:orbital_login/widgets/feeds/floating_menu.dart';
import 'package:orbital_login/widgets/following_list/following_list_part.dart';
import 'package:orbital_login/widgets/notification_list/notifications_list_part.dart';
import 'package:orbital_login/widgets/profile_page/profile_page_part.dart';
import 'package:orbital_login/widgets/team_up/team_up_part.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Notifications',
      style: optionStyle,
    ),
    Text(
      'Team Up',
      style: optionStyle,
    ),
    Text(
      'Following',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];
  Widget bodyFunction() {
    switch (_selectedIndex) {
      case 0:
        return FeedPart();

      case 1:
        return NotificationListPart();

      case 2:
        return TeamUpPart();

      case 3:
        return FollowingListPart();

      default:
        return ProfilePagePart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.confirm,
                    cancelBtnText: "Cancel",
                    onCancelBtnTap: () => Navigator.of(context).pop(),
                    confirmBtnText: "Log Out",
                    onConfirmBtnTap: () => AuthMethods().signOut(context),
                  );
                },
              ),
            )
          ],
        ),
        body: bodyFunction(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.bell,
                  text: 'Notifs',
                ),
                GButton(
                  icon: LineIcons.gamepad,
                  text: 'TeamUp',
                ),
                GButton(
                  icon: LineIcons.userFriends,
                  text: "Following",
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
        floatingActionButton: _selectedIndex != 0 ? null : FloatingMenu());
  }
}
