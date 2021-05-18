import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shose_app/contants.dart';
import 'package:shose_app/services/firebase_services.dart';
import 'package:shose_app/tabs/home_tab.dart';
import 'package:shose_app/tabs/save_tab.dart';
import 'package:shose_app/tabs/search_tab.dart';
import 'package:shose_app/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices=FirebaseServices();
  PageController _tabPageController;
  int SelectedTab=0;
  @override
  void initState() {
    _tabPageController=PageController();
    super.initState();
  }
  @override
  void dispose(){
    _tabPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child:PageView(
              controller: _tabPageController,
              onPageChanged: (num){
                setState(() {
                  SelectedTab=num;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SaveTab(),
              ],
            ),
          ),
          BottomTabs(
            selectedTab: SelectedTab,
            tabPressed: (num){
             _tabPageController.animateToPage(
                 num,
                 duration: Duration(milliseconds: 300),
                 curve: Curves.easeOutCubic
             );
            },
          )

        ],

      ),
    );
  }
}
