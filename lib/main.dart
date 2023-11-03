import 'dart:convert';
import 'package:api_testing/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MaterialApp(home:MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Album>lst=[];
Future<List<Album>>fetchdata()async{
  final  res=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
  if(res.statusCode==200){
    final data=jsonDecode(res.body.toString());
    for(Map<String,dynamic> i in data){
      lst.add(Album.fromJson(i));
    }
    return lst;
  }
  else{

   return lst;
  }
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      future: fetchdata(),
      builder:(context,snapshot){
      if(snapshot.hasError){

        throw Exception('error');
      }
      else if(snapshot.hasData){
        return ListView.builder(itemCount:lst.length,itemBuilder: (context,item){
          return ListTile(
            title: Text(lst[item].title.toString(),),
            subtitle:  Text(lst[item].id.toString(),),
            leading: const Icon(Icons.account_circle),

          );
        });
      }
      else {
        return const Center(child: CircularProgressIndicator());
      }
    },));
  }
}

