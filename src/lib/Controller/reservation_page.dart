import 'package:flutter/material.dart';
import '../Model/user.dart';
import '../Model/palestra.dart';
import 'main_page.dart';
import '../database.dart';

class ReservationPage extends StatelessWidget {
  static const String _title = 'Reservation Page';

  final Palestra palestra;
  final User user;
  final Database database;

  ReservationPage(this.palestra, this.user, this.database);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(this.palestra, this.user, this.database),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final User user;
  final Palestra palestra;
  final Database database;

  MyStatefulWidget(this.palestra, this.user, this.database, {Key key})
      : super(key: key);

  @override
  _MyStatefulWidgetState createState() =>
      _MyStatefulWidgetState(this.palestra, this.user, this.database);
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Palestra palestra;
  User user;
  Database database;

  Color colorSeat = Colors.black;
  int idSelector = -1;

  _MyStatefulWidgetState(this.palestra, this.user, this.database);

  Widget reserveButton() {
    var reserveButton = Container(
      child: FlatButton(
        color: Color(0xFFEE6C4D),
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(150)),
        ),
        onPressed: () {
          if (this.idSelector != -1) {
            this.user.addPalestraGoing(this.palestra);
            this.user.addSeat(idSelector);
            this.palestra.getSeats()[idSelector] = 1;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage(this.user, this.database)));
          } else {}
        },
        child: Text(
          "Reserve the seat",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      height: 50,
      width: 700,
      margin: EdgeInsets.symmetric(horizontal: 70),
    );

    return reserveButton;
  }

  Expanded getSeats() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 11,
        children: getSeatsList(),
        physics: new NeverScrollableScrollPhysics(),
      ),
    );
  }

  List<IconButton> getSeatsList() {
    List<IconButton> seatsList = List<IconButton>();

    for (var i = 0; i < 99; i++) {
      if (this.palestra.getSeats()[i] == -1) {
        colorSeat = Colors.yellow;
      } else if (this.palestra.getSeats()[i] == 0) {
        colorSeat = Colors.white;
      } else if (this.palestra.getSeats()[i] == 1) {
        colorSeat = Colors.red[300];
      }
      if ((idSelector == i) &&
          (this.palestra.getSeats()[i] != -1) &&
          (this.palestra.getSeats()[i] != 1)) colorSeat = Colors.green[500];
      seatsList.add(IconButton(
        icon: Icon(
          const IconData(59147, fontFamily: 'MaterialIcons'),
          size: 30,
          color: colorSeat,
        ),
        onPressed: () {
          setState(() {
            if ((this.palestra.getSeats()[i] != -1) &&
                (this.palestra.getSeats()[i] != 1))
              idSelector = i;
            else
              idSelector = -1;
          });
        },
      ));
    }

    return seatsList;
  }

  Column getPalestraInfo() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          child: Column(
            children: <Widget>[
              // Name
              Container(
                child: Text(
                  this.palestra.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.topLeft,
                padding:
                    EdgeInsets.only(top: 10, left: 25, bottom: 10, right: 25),
              ),
              // Location
              Container(
                child: Row(children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    const IconData(62168, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                    size: 30,
                    semanticLabel: 'Location',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    this.palestra.location,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ]),
                padding: EdgeInsets.only(bottom: 10),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      const IconData(58915, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                      size: 30,
                      semanticLabel: 'Date',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      this.palestra.firstDate.printDate(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      IconData(0xe55b, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                      size: 30,
                      semanticLabel: 'Time',
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      this.palestra.firstDate.printTime(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.only(bottom: 10),
              ),
              // Time
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      IconData(58915, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                      size: 30,
                      semanticLabel: 'Date',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      this.palestra.secondDate.printDate(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      IconData(0xe55b, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                      size: 30,
                      semanticLabel: 'Time',
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      this.palestra.secondDate.printTime(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.only(bottom: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container getGoBackButton(BuildContext context) {
    return Container(
      child: IconButton(
        color: Colors.white,
        icon: Icon(const IconData(61562, fontFamily: 'MaterialIcons')),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(this.user, this.database)),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF293241),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getGoBackButton(context),
/*             Container(
              child: Image.asset(
                'images/logo.png',
                fit: BoxFit.contain,
                height: 55,
              ),
              margin: EdgeInsets.all(10),
            ), */
          ],
        ),
      ),
      backgroundColor: Color(0xFF98C1D9),
      body: Column(
        children: [
          getPalestraInfo(),
          getSeats(),
          reserveButton(),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}
