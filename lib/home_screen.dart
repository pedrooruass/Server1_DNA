import 'dart:convert';
import 'package:HW_tile_json/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> tiles;

  Future<void> getInfos() async {
    http.Response response =
        await http.get("http://api.plos.org/search?q=title:DNA");

       

    if (response.statusCode == 200) {
      final jsonConverted = json.decode(response.body);

      setState(() {
        tiles = jsonConverted["response"]["docs"];
      });
    }
  }

  @override
  initState() {
    super.initState();
    getInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DNA"),
        centerTitle: true,
        leading: Icon(Icons.dashboard_rounded),
        actions: [
          Icon(Icons.dashboard_rounded),
          SizedBox(width: 15),
        ],
      ),

      body: Container(
        alignment: Alignment.center,
        child: tiles != null? ListView(
          children: tiles.map((e) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  title: Text(e["title_display"],style: TextStyle(color: Colors.white),),
                  tileColor: Colors.grey.shade900,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          title: e["title_display"],
                          infos: e["abstract"][0],
                        ),
                      ),
                    );
                  },
                  // Column == WorkAround == Gambiarra
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_forward_ios, color: Colors.white,),
                    ],
                  ),
                  ),
            );
          }).toList(),
        ) : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Searching for News...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
