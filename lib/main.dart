import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Welcome to XATprep'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xff2B3F9F),
      ),
      body: new Container(
        color: Color(0xffD1CCCC),
        child: new Center(
          child: getListOfDecisionMaking(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(backgroundColor: Color(0xff2B3F9F),icon: Icon(Icons.dashboard), title: Text('Dashboard')),
          BottomNavigationBarItem(backgroundColor:Color(0xff2B3F9F), icon: Icon(Icons.lightbulb_outline), title: Text('Decision Making')),
          BottomNavigationBarItem(backgroundColor:Color(0xff2B3F9F),icon: Icon(Icons.account_balance), title: Text('GK')),
          BottomNavigationBarItem(backgroundColor:Color(0xff2B3F9F),icon: Icon(Icons.forum), title: Text('Forum')),

        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.white,
        backgroundColor: Colors.orange,
        type: BottomNavigationBarType.shifting,
        onTap: onItemTapped,
      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchTests();
  }

  getListOfDecisionMaking(){
    switch(selectedIndex){
      case 0:{
        return ListView(
          children: <Widget>[
            Container(
              height: 160.0,
              padding: EdgeInsets.all(0.0),
              margin: EdgeInsets.only(left:0.0, bottom: 5.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                color: Colors.white,
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
//                          Container(
//                            height: 100.0,
//                            child: Image.asset('assets/images/about.png'),
//                          ),
                          Container(
                            height: 100.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(child: Text("About", style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, height: 1.5),),),
                                Expanded(child: Container(
                                  margin: EdgeInsets.only(top:4.0),
                                  width: 225.0,
                                  child: Text("Ace your preparation for Decision Making and GK with XATprep.com", style: TextStyle(fontSize: 16.0, fontFamily: 'Roboto', color: Colors.black),),),),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 300.0,
              padding: EdgeInsets.all(0.0),
              margin: EdgeInsets.only(left:0.0, bottom: 5.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                color: Colors.white,
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    height: MediaQuery.of(context).size.height * 0.35,

                    child: FutureBuilder<List<Test>>(
                      future: fetchTests(),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
//                           loaded = snapshot.data;
                          return new ListView.builder(
                            scrollDirection: Axis.horizontal,
//                            itemCount: loaded.length,
                            itemCount:snapshot.data.length,
                            itemBuilder: (BuildContext context, int index){
                              //var db_object = db_objects[index];
                              return new Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Container(
                                  child: Center(child: Text(snapshot.data[index].name)),
                                ),
                              );
                            },
                          );
                        }else{
                          return CircularProgressIndicator();
                        }
                        //var db_objects = json.decode(snapshot.data.toString());

                      },
                    ),
//                      child: ListView.builder(
//                          scrollDirection: Axis.horizontal,
//                          itemCount: numbers.length, itemBuilder: (context, index) {
//                        return Container(
//                          width: MediaQuery.of(context).size.width * 0.6,
//                          child: Card(
//                            color: Colors.blue,
//                            child: Container(
//                              child: Center(child: Text(numbers[index].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
//                            ),
//                          ),
//                        );
//                      }),
                  ),
//                  child: Column(
//                    children: <Widget>[
//                      Row(
//                        children: <Widget>[
//                          Container(
//                            height: 100.0,
//                            child: Image.asset('assets/images/decision_making.png'),
//                          ),
//                          Container(
//                            height: 250.0,
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Container(child: Text("Decision Making Section", style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, height: 1.5),),),
//                                Container(
//                                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
//                                  height: MediaQuery.of(context).size.height * 0.35,
//                                  child: ListView.builder(
//                                      scrollDirection: Axis.horizontal,
//                                      itemCount: numbers.length, itemBuilder: (context, index) {
//                                    return Container(
//                                      width: MediaQuery.of(context).size.width * 0.6,
//                                      child: Card(
//                                        color: Colors.blue,
//                                        child: Container(
//                                          child: Center(child: Text(numbers[index].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
//                                        ),
//                                      ),
//                                    );
//                                  }),
//                                ),
//                                Expanded(child: Text("welcomerer"),
//                                ),
//
//
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
                ),
              ),
            ),

            Container(
              height: 160.0,
              padding: EdgeInsets.all(0.0),
              margin: EdgeInsets.only(left:0.0, bottom: 5.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                color: Colors.white,
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
//                          Container(
//                            height: 100.0,
//                            child: Image.asset('assets/images/gk.png'),
//                          ),
                          Container(
                            height: 100.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(child: Text("General Knowledge", style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, height: 1.5),),),
                                Expanded(child: Container(
                                  margin: EdgeInsets.only(top:4.0),
                                  width: 225.0,
                                  child: Text("Ace your preparation for Decision Making and GK with XATprep.com", style: TextStyle(fontSize: 16.0, fontFamily: 'Roboto', color: Colors.black),),),),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              height: 150.0,
              padding: EdgeInsets.all(0.0),
              margin: EdgeInsets.only(left:0.0, bottom: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                color: Colors.white,
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
//                          Container(
//                            height: 100.0,
//                            child: Image.asset('assets/images/about.png'),
//                          ),
                          Container(
                            height: 100.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(child: Text("Forum", style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, height: 1.5),),),
                                Expanded(child: Container(
                                  margin: EdgeInsets.only(top:4.0),
                                  width: 225.0,
                                  child: Text("Ace your preparation for Decision Making and GK with XATprep.com", style: TextStyle(fontSize: 16.0, fontFamily: 'Roboto', color: Colors.black),),),),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        );
      }
      case 1:{
        return Text("Welcome to Decision Making", style: TextStyle(fontFamily: 'Roboto', color: Colors.grey, fontSize: 24.0, fontWeight: FontWeight.normal));
      }
      case 2:{
        return Text("Welcome to GK", style: TextStyle(fontFamily: 'Roboto', fontSize: 24.0, fontWeight: FontWeight.normal));
      }
      case 3:{
        return Text("Welcome to the Forum", style: TextStyle(fontFamily: 'Roboto', fontSize: 24.0, fontWeight: FontWeight.normal));
      }
    }



  }

//  Future<Test> fetchTests() async {
//
//    //final response =await http.get('http://www.xatprep.com/api/get_tests.php');
//    final response =await http.get('https://jsonplaceholder.typicode.com/posts');
//    if(response.statusCode ==200){
//      print("data received from API");
//
//
//
//      return Test.fromJson(json.decode(response.body));
//
//    }else{
//      throw Exception("Some issue here. Please try to restart the application");
//    }
//  }

  Future<List<Test>> fetchTests() async {
    final response =await http.get('https://www.xatprep.com/api/get_tests.php');
    //final response = await http.get('https://jsonplaceholder.typicode.com/posts');
    print(response.body);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.

      Iterable list = json.decode(response.body);
      var tests = new List<Test>();
      tests = list.map((model) => Test.fromJson(model)).toList();

      return tests;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
//
//  Future<Test> fetchTests() async {
//    //final response =await http.get('https://www.xatprep.com/api/get_tests.php');
//    final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
//    print(response.body);
//    if (response.statusCode == 200) {
//      // If server returns an OK response, parse the JSON.
//      return Test.fromJson(json.decode(response.body));
//    } else {
//      // If that response was not OK, throw an error.
//      throw Exception('Failed to load post');
//    }
//  }

//  displayDMCards(){
//    FutureBuilder<Test>(
//      future: test,
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          return Text(snapshot.data.name);
//        } else if (snapshot.hasError) {
//          return Text("${snapshot.error}");
//        }
//
//        // By default, show a loading spinner.
//        return CircularProgressIndicator();
//      },
//    );
//  }



//  displayDMCards(){
//    return new FutureBuilder(
//        future: test,
//        builder: (context, snapshot) {
//          var db_objects = json.decode(snapshot.data.toString());
//
//          return new ListView.builder(
//            scrollDirection: Axis.horizontal,
//            itemCount: db_objects == null ? 0 : db_objects.length,
//            itemBuilder: (BuildContext context, int index) {
//              var db_object = db_objects[index];
//              return new Card(
//                child: new Column(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    new Text("Name: " + db_object['name'],
//                        style: TextStyle(
//                            fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 24)),
//                    new Text("Description: " + db_object['name'],
//                        style: TextStyle(
//                            fontFamily: 'Roboto', color: Colors.blueGrey, fontWeight: FontWeight.normal, fontSize: 20)),
////                    new Image.asset('assets/images/xat2017.png'),
//                  ],
//                ),
//              );
//            },
//
//          );
//        });
//  }

//  getListofItems(){
//    return new FutureBuilder(
//        future: DefaultAssetBundle.of(context)
//            .loadString('assets/dm_list.json'),
//        builder: (context, snapshot) {
//          var db_objects = json.decode(snapshot.data.toString());
//
//          return new ListView.builder(
//            itemBuilder: (BuildContext context, int index) {
//              var db_object = db_objects[index];
//              return new Card(
//                child: new Column(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    new Text("Name: " + db_object['name'],
//                        style: TextStyle(
//                            fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 24)),
//                    new Text("Description: " + db_object['description'],
//                        style: TextStyle(
//                            fontFamily: 'Roboto', color: Colors.blueGrey, fontWeight: FontWeight.normal, fontSize: 20)),
//                    new Text("Image: " + db_object['image'],
//                        style: TextStyle(
//                            fontFamily: 'Roboto', fontWeight: FontWeight.normal, fontSize: 20)),
//                    new Image.asset('assets/images/xat2017.png'),
//                  ],
//                ),
//              );
//            },
//            itemCount: db_objects == null ? 0 : db_objects.length,
//          );
//        });
//  }



  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class Test {
  final String name;


  Test({this.name});

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      name: json['name'],
    );
  }
}


