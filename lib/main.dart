import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO APP',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> enteredTexts = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _addText() {
    setState(() {
      String text = _textEditingController.text;
      if (text.isNotEmpty) {
        enteredTexts.add(text);
        _textEditingController.clear();
      }
    });
  }

  void _removeText(int index) {
    setState(() {
      enteredTexts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the scaffold key
      appBar: AppBar(
        title: Text('This is to do app '),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu icon',
          onPressed: () {
            _scaffoldKey.currentState!
                .openDrawer(); // Open the drawer using the scaffold key
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter your text here...',
                ),
              ),
              ElevatedButton(
                  onPressed: _addText,
                  child: Text('Add'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  )),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: enteredTexts.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(enteredTexts[index]),
                      onDismissed: (direction) {
                        _removeText(index);
                      },
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete, color: Colors.white),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(enteredTexts[index]),
                            Icon(Icons.delete),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: MyDrawer(),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Map'),
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Album'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
        ),
        ListTile(
          leading: Icon(Icons.contacts),
          title: Text('Contact'),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Setting'),
        ),
      ],
    );
  }
}
