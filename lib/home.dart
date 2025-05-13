import 'package:flutter/material.dart';

import 'cofee.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool isVisible = true;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Welcome to food world',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.greenAccent,
              indicatorColor: Colors.yellow,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorAnimation: TabIndicatorAnimation.elastic,
              controller: _tabController,
              tabs: [
                Tab(text: "Home",),
                Tab(text: "Orders"),
                Tab(text: "Favourite"),
                Tab(text: "Profile"),
              ],
            ),
          ),

          body: TabBarView(
            controller: _tabController,
            children: [Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Hero(
                      tag: 'myImage',
                      child: Image.asset(
                        'assets/images/desrt.jpg',
                        width: 400,
                        height: 400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: isVisible,
                    child: Wrap(
                      spacing: 40,
                      children: [
                        Chip(label: Text('Burger')),
                        Chip(label: Text('pizza')),
                        Chip(label: Text('desert')),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondScreen(),
                        ),
                      );
                    },
                    child: Text('Order page'),
                  ),
                ],
              ),
            ),
              MainPage(),
             Screen(),
        ]
          ),
        );
      },
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orders",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.grey,
      ),
      body:Card(
        color: Colors.greenAccent.shade100,
        margin: EdgeInsets.all(50),
        elevation: 9,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),


       child: Column(
         children: [
           ClipRRect(
             borderRadius: BorderRadius.circular(20),
               child: Image.asset('assets/images/desrt.jpg',
               height: 200,
               width: 500,
               fit: BoxFit.cover,
               )
           ),
           Text("order Desert")
         ],
       ),
        



      ) 
      );
    
  }
}
