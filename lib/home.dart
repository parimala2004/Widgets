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
class MyMainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purpleAccent,
          foregroundColor: Colors.greenAccent,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final StreamController<int> _streamController = StreamController<int>();

  HomePage() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      _streamController.sink.add(Random().nextInt(100));
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Hello'),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 100.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Sliver Demo'),
                  background: CustomPaint(
                    painter: CirclePainter(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: StreamBuilder<int>(
                        stream: _streamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              'Current Value: ${snapshot.data}',
                              style: TextStyle(fontSize: 20),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(' List Items:', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(
                    title: Text(' item $index'),
                  ),
                  childCount: 5,
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      height: 200,
                      width: 200,
                      color: Colors.yellowAccent,
                      child: Center(child: Text("Grid$index"),),

                    );
                  },
                  childCount: 10,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 600 ? 4 : 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 50, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
