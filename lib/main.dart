import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getUserData() async{
    var response = await http.get(Uri.http("jsonplaceholder.typicode.com","users"));
    var jsonData=jsonDecode(response.body);
    List<User> users=[];

    for(var u in jsonData){
      User user=User(u["name"],u["email"],u["username"]);
      users.add(user);

    }
    print(users.length);
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Http get Method"),),
    body: Container(
      child: Card(child: FutureBuilder(
        future: getUserData(),
        builder: (context,snapshot){
          if(snapshot.data==null){
            return Container(child: Center(child: Text('Loading....'),),);
          }else
            return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context,i){
              return ListTile(
                title:Text(snapshot.data[i].name),
                subtitle: Text(snapshot.data[i].email),
                trailing: Text(snapshot.data[i].userName),

              );
            },);

        },
      ),
      ),
    )
    );
  }
}

class User{
  final String name,email,userName;

  User(this.name, this.email, this.userName);
}