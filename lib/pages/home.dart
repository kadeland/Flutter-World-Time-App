import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    print(data);

    //set background
    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color bgcolor = data['isDayTime'] ? Colors.blue : Colors.black;
    Color textColor = data['isDayTime'] ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120.0,0,0),
              child: Column(
                children: [
                  FlatButton.icon(
                      onPressed: () async{
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'isDayTime': result['isDayTime'],
                            'flag': result['flag'],
                          };
                        });

                        },
                      icon: Icon(
                          Icons.edit_location,
                        color: textColor,
                      ),
                      label: Text(
                          'Edit Location',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                  ),
                  const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    data['location'],

                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: textColor,
                    ),
                    ),
                  ],
                ),
                  const SizedBox(height: 30.0,),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 50.0,
                      letterSpacing: 1.0,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
