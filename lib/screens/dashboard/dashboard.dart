import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/screens/screens.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  int _page = 0;
  final _pageController = PageController();
  final List<Widget> _pages = [
    const HomeScreen(),
    const AttendenceScreen(),
    const Sutrascreen(),
    const PointScreen(),
    const ProfileScreen()
  ];
  List<MenuItem> d = [
    MenuItem(
      value: '1',
      label: 'ID Card',
      icon: const Icon(FontAwesomeIcons.idCard),
    ),
    MenuItem(
      value: '2',
      label: 'Add Child',
      icon: const Icon(Icons.person_add),
    ),
    MenuItem(
      value: '3',
      label: 'Switch Child',
      icon: const Icon(Icons.switch_account),
    ),
  ];
  String studentname = '';
  @override
  void initState() {
    statusBarColor(navigationBarColor: AppColors.primaryColor);
    List<StudentModel> studentList = filterStudents();
    studentname = studentList[0].fullName!;
    statusBarColor(statsBarBright: Brightness.dark);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: _page == 0 ? Colors.grey.shade100 : Colors.white,
      key: _key,
      bottomNavigationBar: bottomBar(),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (context, i) {
              return Column(
                children: [topCard().p(10), Expanded(child: _pages[i])],
              );
            }),
      ),
    );
  }

  Card topCard() {
    return Card(
      color: AppColors.primaryColor,
      child: SizedBox(
        width: Get.width,
        height: 60,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  _key.currentState?.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 28,
                )),
            5.hs(),
            Image.asset(
              logo,
              width: 45,
              fit: BoxFit.fitWidth,
            ),
            10.hs(),
            VStack([
              studentname.text
                  .scale(0.9)
                  .white
                  .maxLines(1)
                  .overflow(TextOverflow.ellipsis)
                  .make(),
              "MNP ID : ${box.read(Keys.sid)}".text.scale(0.7).white.make()
            ]).flexible(),
            20.hs(),
            const Icon(
              Icons.notifications,
              color: Colors.white,
            ).onTap(() {
              Get.to(() => const NotificationsScreen());
            }),
            PopupMenuButton(
              onSelected: (value) {
                if (value == '1') {
                  Get.to(() => const IdcardScreen());
                } else if (value == '2') {
                  Get.to(() => const LoginScreen(
                        addNew: true,
                      ));
                } else if (value == '3') {
                  Get.to(() => const SwitchChildScreen())!.then((_) {
                    setState(() {});
                  });
                }
              },
              iconSize: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Colors.white,
              elevation: 10,
              iconColor: Colors.white,
              itemBuilder: (context) {
                return d.map((e) {
                  return PopupMenuItem(
                      value: e.value,
                      child: Row(
                        children: [
                          e.icon,
                          10.hs(),
                          Text(e.label),
                        ],
                      ));
                }).toList();
              },
            ),
          ],
        ).px(5),
      ),
    );
  }

  CurvedNavigationBar bottomBar() {
    return CurvedNavigationBar(
      height: 60,
      index: 0,
      items: [
        barItems(icon: Icons.home, label: "Home", index: 0),
        barItems(icon: Icons.calendar_month, label: "Attendance", index: 1),
        barItems(icon: Icons.book, label: "Sutra", index: 2),
        barItems(icon: Icons.star, label: "Points", index: 3),
        barItems(icon: Icons.person_outlined, label: "Profile", index: 4),
      ],
      color: AppColors.primaryColor,
      buttonBackgroundColor: AppColors.primaryColor,
      backgroundColor: (_page == 0) ? Colors.transparent : Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 350),
      onTap: (index) {
        setState(() {
          _page = index;
        });
        _pageController.jumpToPage(index);
      },
      letIndexChange: (index) => true,
    );
  }

  VStack barItems(
      {required IconData icon, required String label, required int index}) {
    return VStack(
      [
        if (_page != index) 15.vs(),
        Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
        (_page != index ? 3 : 0).vs(),
        if (_page != index) label.text.white.scale(0.70).make()
      ],
      crossAlignment: CrossAxisAlignment.center,
    );
  }
}

class MenuItem {
  final String value;
  final String label;
  final Widget icon;

  MenuItem({required this.value, required this.label, required this.icon});
}
