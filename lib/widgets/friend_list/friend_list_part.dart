import 'package:flutter/material.dart';
import 'package:orbital_login/models/user.dart';
import 'package:orbital_login/widgets/friend_list/friend_list_item.dart';
import 'package:orbital_login/widgets/chat_room/search_bar.dart';
import 'package:provider/provider.dart';

class FriendListPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<AppUser> friendList = Provider.of<AppUser>(context).friendList!;

    return Container(
      child: Column(
        children: [
          SearchBar(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return FriendListItem(friendList[index]);
              },
              itemCount: friendList.length,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/home/search-following-screen');
            },
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  border: Border.all(color: Colors.purple.shade900, width: 1)),
              width: 300,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/add-user.png',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Follow people",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    softWrap: true,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }
}
