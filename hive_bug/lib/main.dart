import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
part 'main.g.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive..init(directory.path+'/hive' )..registerAdapter(PersonAdapter());


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage( 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title) ;

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Person? _person;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
            children: [

              MaterialButton(onPressed: () async {
                var box = await Hive.openBox('testBox');
                var person = Person(age: 3809317795770925130);
                await box.put('person', person);
                Fluttertoast.showToast(msg: 'save success,please restart app',gravity: ToastGravity.CENTER,fontSize: 16,textColor: Colors.red);
              },child: Text('save age value： 3809317795770925130'),color: Colors.green,),
              MaterialButton(onPressed: () async {
                var box = await Hive.openBox('testBox');
                setState(() {
                  _person=box.get('person');
                });

              },child: Text('read value：${_person?.age}'),color: Colors.blue,),
              Text('The app needs to be restarted before reading the value data',style: TextStyle(color: Colors.red,fontSize: 20,),),

            ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


@HiveType(typeId: 1)
class Person {
  Person({required this.age});
  @HiveField(1)
  int age;

}