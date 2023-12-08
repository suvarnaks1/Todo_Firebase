

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welcome_todo/group.dart';
import 'package:welcome_todo/menupage.dart';
import 'package:welcome_todo/tasklist.dart';
import 'package:welcome_todo/theme_provide.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

String? loggedInUserName;

  @override
  void initState() {
    super.initState();
    
  }
 
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
           automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 200,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("welcome",style: TextStyle(color: Colors.black),),
                   IconButton(
                onPressed: () {Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();},
                icon: Icon(Icons.light_mode_rounded,color: Colors.black,)
              ),
                ],
              ),
             
              SizedBox(height: 10), // Add spacing between text/icon and tabs
              SearchBar(),
              SizedBox(height: 10), // Add additional spacing between search bar and tabs
              buildTabBar(),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Replace these with your tab views
            TaskPage(),
           UserListPage(),
            SignOutPage(),
          ],
        ),
      ),
    );
  }

  Widget buildTabBar() {
    return TabBar(
      tabs: [
        Tab( iconMargin: EdgeInsets.all(0),
          icon: Icon(Icons.task),
          text: 'Tasks',),
        Tab(    iconMargin: EdgeInsets.all(0),
          icon: Icon(Icons.group),
          text: 'Group',),
        Tab(   iconMargin: EdgeInsets.all(0),
          icon: Icon(Icons.menu),
          text: 'Menu',),
      ],
      labelColor: Colors.amber, // Customize the tab label color
      unselectedLabelColor: Colors.black54, // Customize the unselected tab label color
      indicatorColor: Colors.amber, // Customize the indicator color
    );
  }

  Widget buildTabView(String content) {
    return Center(
      child: Text(content),
    );
  }
  
  Auth() {}
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.black54),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}































// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:welcome_todo/group.dart';
// import 'package:welcome_todo/loginpage.dart';
// import 'package:welcome_todo/menupage.dart';
// import 'package:welcome_todo/theme_provide.dart';

// import 'tasklist.dart';

// class WelcomePage extends StatefulWidget {
//   WelcomePage({Key? key}) : super(key: key);

//   @override
//   _WelcomePageState createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final TextEditingController _searchText = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   //name add
//   final Auth _auth = Auth();

//   @override
//   Widget build(BuildContext context) {
// //name add

//     return Scaffold(
//       backgroundColor: Colors.white,
//       // backgroundColor: Theme.of(context).colorScheme.background,

//       appBar: _appBar(),
//       body: Center(
//         child: TabBarView(
//           controller: _tabController,
//           children: [
//             const Taskpage(),

//             UserListPage(),
//            SignOutPage()

//             // _tabBarViewItem(Icons.menu, 'Menu'),
//           ],
//         ),
//       ),
//     );
//   }

//   // PreferredSize
//   _appBar() {
//     String? userEmail = _auth.getCurrentUserEmail();
//     String username = userEmail != null ? userEmail.split('@')[0] : '';

//     return PreferredSize(
//       preferredSize: Size.fromHeight(200),

//       child: Container(

//         margin: EdgeInsets.only(top: 5),
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         decoration: _boxDecoration(),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Center(
//                       child: Text(
//                         'Welcome $username',

//                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 23),
//                       ),
//                     ),
//                     IconButton(onPressed: () {
//                        Provider.of<ThemeProvider>(context, listen: false)
//                         .toggleTheme();
//                     }, icon: Icon(Icons.light_mode_rounded,color: Colors.black,))
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 _searchBox(),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 _tabBar(),
//               ],
//             ),
//           ),

//         ),)
//     );
//   }

//   BoxDecoration _boxDecoration() {
//     return BoxDecoration(
//       borderRadius: const BorderRadius.vertical(
//         bottom: Radius.circular(20),
//       ),
//       gradient: LinearGradient(
//         colors: [Colors.white, Colors.white],
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//       ),
//     );
//   }

//   Widget _searchBox() {
//     return SizedBox(
//       height: 45,
//       child: TextFormField(
//         textAlign: TextAlign.start,
//         controller: _searchText,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           prefixIcon: const Icon(Icons.search),
//           suffixIcon: InkWell(
//             child: const Icon(Icons.close),
//             onTap: () {
//               _searchText.clear();
//             },
//           ),
//           hintText: 'Search...',
//           contentPadding: const EdgeInsets.all(0),
//           border: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//         ),
//       ),
//     );
//   }

//   // ... (rest of your code remains unchanged)

//   Widget _tabBar() {
//     print(Theme.of(context).brightness);
//     print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
//     return TabBar(
//       controller: _tabController,
//       labelPadding: const EdgeInsets.all(0),
//       labelColor:Colors.amber,
//       //  Theme.of(context).brightness == Brightness.light
//       //     ? Colors.amber
//       //     : Colors.white,
//       indicatorColor: Colors.white,
//       unselectedLabelColor: Colors.black,
//       tabs: const [
//         Tab(
//           iconMargin: EdgeInsets.all(0),
//           icon: Icon(Icons.task),
//           text: 'Tasks',
//         ),
//         Tab(
//           iconMargin: EdgeInsets.all(0),
//           icon: Icon(Icons.group),
//           text: 'Group',
//         ),
//         Tab(
//           iconMargin: EdgeInsets.all(0),
//           icon: Icon(Icons.menu),
//           text: 'Menu',
//         ),
//       ],
//       // iconTheme: Theme.of(context).iconTheme,
//     );
//   }

//   Widget _tabBarViewItem(IconData icon, String name) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           icon,
//           size: 200,
//         ),
//         Text(
//           name,
//           style: const TextStyle(fontSize: 60),
//         ),
//       ],
//     );
//   }

// }