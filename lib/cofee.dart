import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> items = ['burger','Pizza', 'desset',];

  String? draggedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.greenAccent,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "My order",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown),
              ),
            ),

            // Scrollable List
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Draggable<String>(
                      data: item,
                      onDragStarted: () => draggedItem = item,
                      onDraggableCanceled: (_, __) => draggedItem = null,
                      onDragEnd: (_) => draggedItem = null,
                      feedback: Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: _buildListTile(item),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.3,
                        child: _buildListTile(item),
                      ),
                      child: _buildListTile(item),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.bottomRight,
              child: DragTarget<String>(
                onAccept: (data) {
                  setState(() {
                    items.remove(data);
                    draggedItem = null;
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor:
                      candidateData.isNotEmpty ? Colors.white : Colors.red,
                      child: const Icon(Icons.add_a_photo),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title) {
    return ListTile(
      tileColor: const Color(0xFFF5E6DA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      leading: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/desrt.jpg"),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown),
      ),
      subtitle: const Text(
        "300",
        style: TextStyle(fontSize: 15, color: Colors.brown),
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 40,
          width: 40,
          color: Colors.black26,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
class Screen extends StatefulWidget {
  @override
  State<Screen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Screen> with TickerProviderStateMixin {
  int selectedIndex=-1;
  List<String> items = ['Apple','Orange','Mango','Grapes'];
  bool isExpanded = false;
  bool isVisible = true;

  late AnimationController fadeController;
  late AnimationController scaleController;

  @override
  void initState() {
    super.initState();
    fadeController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    scaleController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.5,
      upperBound: 1.0,
    );

    fadeController.forward();
    scaleController.repeat(reverse: true);
  }

  @override
  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "List"),
              Tab(text: "Animations"),
              Tab(text: "Page View"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = items.removeAt(oldIndex);
                  items.insert(newIndex, item);
                });
              },
              children: [
                for (int index = 0; index < items.length; index++)
                  ListTile(
                    key: ValueKey(items[index]),
                    title: Text(items[index]),
                    tileColor: selectedIndex == index ? Colors.grey : Colors.greenAccent,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: isExpanded ? 200 : 100,
                    height: isExpanded ? 300 : 100,
                    color: isExpanded ? Colors.blue : Colors.orange,

                  ),
                  SizedBox(height: 10),
                  AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    duration: Duration(seconds: 2),
                    child: Text("Welocome to Food World",style: TextStyle(color: Colors.greenAccent,fontWeight:FontWeight.bold ),),
                  ),
                  SizedBox(height: 10),
                  FadeTransition(
                    opacity: fadeController,
                    child: Text("Hii Foodie"),
                  ),
                  SizedBox(height: 10),
                  ScaleTransition(
                    scale: scaleController,
                    child: Icon(Icons.star, size: 40),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                        isVisible = !isVisible;
                      });
                    },
                    child: Text("click here"),
                  )
                ],
              ),
            ),
            PageView(
              children: [
                Center(child: Text("Hii")),
                Center(child: InteractiveViewer(panEnabled: true, minScale: 0.5, maxScale: 2.0,
                  child: Image.asset("assets/images/desrt.jpg", height: 200,),)
                ),
                Center(child: Text("Hello")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
