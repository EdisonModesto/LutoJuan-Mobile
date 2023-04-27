import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lutojuan/Features/3.%20CalorieTracking/TrackView.dart';
import 'package:lutojuan/Features/4.%20Profile/ProfileView.dart';
import 'package:lutojuan/Features/NavBar/PrivacyPolicyView.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../1. NewsFeed/Home_View.dart';
import '../2. CreateRecipe/Create_View.dart';
import 'generateLoading.dart';

class AppNavBar extends ConsumerStatefulWidget {
  const AppNavBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AppNavBarState();
}

class _AppNavBarState extends ConsumerState<AppNavBar> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);


  List<Widget> _buildScreens() {
    return [
      const HomeVIew(),
      const CreateView(),
      const TrackView(),
      const ProfileView()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.fastfood_outlined),
        title: ("Create Recipe"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.calendar),
        title: ("Calorie Tracker"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  void showPolicy()async{
    await Future.delayed(const Duration(seconds: 2));
    showDialog(context: context, builder: (builder){
      return Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 600,
                child: PrivacyPolicyView()
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    showPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choos
      onItemSelected: (index){
        if(index == 1){
          showDialog(context: context, builder: (builder){
            return const GenerateLoading();
          });
        }
      },// e the nav bar style with this property.
    );
  }
}
