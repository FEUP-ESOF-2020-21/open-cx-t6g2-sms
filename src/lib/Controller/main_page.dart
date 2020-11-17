import 'package:flutter/material.dart';
import '../Model/palestra.dart';
import '../Model/date.dart';
import '../View/palestra_view.dart';

class MainPage extends StatelessWidget {
  static const String _title = 'Main Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String text;

  _MyStatefulWidgetState({this.text = ""});

  int _selectedIndex = 0;

  final _searchBarController = TextEditingController();

  void removePalestras(List<Palestra> palestras) {
    int palestrasSize = palestras.length;
    if (this.text != "") {
      for (var i = palestrasSize - 1; i >= 0; i--) {
        if (!palestras[i].getSearchResult().contains(text)) {
          palestras.remove(palestras[i]);
        }
      }
    }
  }

  List<Palestra> getPalestras() {
    var palestras = List<Palestra>();
    var palestra1 = new Palestra("Palestra #1", new Date(2000, 12, 2, 12, 30),
        new Date(2000, 12, 2, 14, 30), "Viseu", false);
    var palestra2 = new Palestra("Palestra #2", new Date(2000, 12, 2, 12, 30),
        new Date(2000, 12, 2, 14, 30), "Viseu", false);
    var palestra3 = new Palestra("Palestra #3", new Date(2000, 12, 2, 12, 30),
        new Date(2000, 12, 2, 14, 30), "Porto", false);

    palestras.add(palestra1);
    palestras.add(palestra2);
    palestras.add(palestra1);
    palestras.add(palestra2);
    palestras.add(palestra1);
    palestras.add(palestra2);
    palestras.add(palestra1);
    palestras.add(palestra2);
    palestras.add(palestra2);
    palestras.add(palestra2);
    palestras.add(palestra2);
    palestras.add(palestra2);
    palestras.add(palestra2);
    palestras.add(palestra2);
    palestras.add(palestra2);
    palestras.add(palestra3);
    palestras.add(palestra3);
    palestras.add(palestra3);
    palestras.add(palestra3);

    removePalestras(palestras);

    return palestras;
  }

  Container getSearchBar() {
    return Container(
      child: Row(
        children: [
          Container(
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Search...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              controller: this._searchBarController,
              onSubmitted: (_searchBarController) {
                this.text = this._searchBarController.text;
                setState(() {
                  this._searchBarController.text;
                });
              },
            ),
            height: 50,
            width: 350,
          ),
          Container(
            child: IconButton(
              icon: Icon(
                IconData(59828, fontFamily: 'MaterialIcons'),
                size: 40,
              ),
              color: Colors.white,
              tooltip: 'Search',
              onPressed: () {
                this.text = this._searchBarController.text;
                setState(() {
                  this._searchBarController.text;
                });
              },
            ),
            margin: EdgeInsets.all(1),
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 20, right: 1),
    );
  }

  List<Widget> getWidgetOptions() {
    return <Widget>[
      ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          getSearchBar(),
          SizedBox(
            height: 30,
          ),
          Column(
            children: getPalestras()
                .map((palestra) => new PalestraView(palestra).build(context))
                .toList(),
          )
        ],
      ),
      Text(
        'Coming soon...',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF293241),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                'images/logo.png',
                fit: BoxFit.contain,
                height: 40,
              ),
              margin: EdgeInsets.only(left: 10),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF98C1D9),
      body: Center(
        child: getWidgetOptions().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              IconData(59147, fontFamily: 'MaterialIcons'),
            ),
            label: 'All Conferences',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconData(59171,
                  fontFamily: 'MaterialIcons', matchTextDirection: true),
            ),
            label: 'My Conferences',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}