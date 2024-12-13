import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/newsmodel.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {

 

  Future<NewsModel>fetchNews() async{
     
     final url = "https://newsapi.org/v2/everything?q=tesla&from=2024-11-13&sortBy=publishedAt&apiKey=e17e0929e5734ce38ae87013c2e894d8";

     var response = await http.get(Uri.parse(url));

     if(response.statusCode==200){
        final result = jsonDecode(response.body);
        return NewsModel.fromJson(result);
     }

     else{
          return NewsModel();
     }
  }

   @override
  void initState() {  
    super.initState();
    fetchNews();   
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
        
        body: FutureBuilder(future: fetchNews(), builder: (context, snapshot){
           
           return ListView.builder(itemBuilder: (context, index){
                  return ListTile(
                     leading: CircleAvatar(
                       backgroundImage: NetworkImage("${snapshot.data!.articles![index].urlToImage}"),
                     ),

                     title: Text("${snapshot.data!.articles![index].title}"),
                     subtitle: Text("${snapshot.data!.articles![index].description}"),
                  );
           }, itemCount: snapshot.data!.articles!.length,);
        }),
    );
  }
}