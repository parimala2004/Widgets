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