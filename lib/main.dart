import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gdscmusciplayer/home_res_model.dart';
import 'package:gdscmusciplayer/song_tile.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SearchResponse? searchResponse;
  String searchName = "Telugu";

  late AudioPlayer player;

  playSong(String url) async {
    final duration = await player.setUrl(url);
    print(duration);
    player.setVolume(1);
    player.play();
  }

  getData() async {
    try {
      Response response = await http.get(Uri.parse(
          "https://saavan-music-api.vercel.app/search/songs?query=$searchName&page=1&limit=20"));

      SearchResponse _data = SearchResponse.fromJson(response.body);
      setState(() {
        searchResponse = _data;
      });
    } catch (e) {
      print(e);
      print("exception raise");
    }
  }

  onClickSeach() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Enter seach term"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("cancel")),
                ElevatedButton(
                    onPressed: () {
                      getData();
                      Navigator.pop(context);
                    },
                    child: Text("seach"))
              ],
              content: TextField(
                onChanged: (value) => {
                  setState(() {
                    searchName = value;
                  })
                },
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Music Player"),
          actions: [
            IconButton(
              onPressed: () {
                // getData();
                onClickSeach();
              },
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
            const SizedBox(width: 20)
          ],
        ),
        body: searchResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: searchResponse!.data.result.results.length,
                itemBuilder: (context, index) {
                  return SongTile(
                      title: searchResponse!.data.result.results[index].name,
                      subTitle: searchResponse!.data.result.results[index].year,
                      image: searchResponse!
                          .data.result.results[index].images[0].link,
                      audio: searchResponse!
                          .data.result.results[index].downloadUrl[0].link,
                      onTap: () {
                        playSong(searchResponse!
                            .data.result.results[index].downloadUrl[searchResponse!
                            .data.result.results[index].downloadUrl.length-1].link);
                      });
                },
              ));
  }
}
