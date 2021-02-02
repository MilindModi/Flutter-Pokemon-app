
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapp/ar_page.dart';
import 'dart:convert';
import 'dart:async';
import 'package:pokeapp/pokemon.dart';
import 'package:pokeapp/pokemon_detail.dart';
import 'package:camera/camera.dart';

import 'ar_demo.dart';

List<CameraDescription> cameras;


Future<void>  main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();

  } on CameraException catch (e) {
    print(e.code);
    print(e.description);
  }

  runApp(Temp());
}

class Temp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    setState(() {
      pokeHub = PokeHub.fromJson(decodedJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Poke app'),
          backgroundColor: Colors.cyan,
        ),
        body: pokeHub == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.count(
                crossAxisCount: 2,
                children: pokeHub.pokemon
                    .map((poke) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PokemonDetail(pokemon: poke)));
                            },
                            child: Hero(
                              tag: poke.img,
                              child: Card(
                                elevation: 3.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 100.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(poke.img))),
                                    ),
                                    Text(
                                      poke.name,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
        // : Center(child: Text("Loading...")),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage()));
                },
              ),
              ListTile(
                title: Text('Charmander'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ARDemo()));
                },
              ),
              ListTile(
                title: Text('pikachu'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HelloWorld(cameras,'pikachu')));
                },
              ),
              ListTile(
                title: Text('bulbasaur'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HelloWorld(cameras,'bulbasaur')));
                },
              ),
              ListTile(
                title: Text('eevee'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HelloWorld(cameras,'eevee')));
                },
              ),
              ListTile(
                title: Text('jigglypuff'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HelloWorld(cameras,'jigglypuff')));
                },
              ),
              ListTile(
                title: Text('mew'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HelloWorld(cameras,'mew')));
                },
              ),
              ListTile(
                title: Text('snorlax'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HelloWorld(cameras,'snorlax')));
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchData,
          child: Icon(Icons.refresh),
        ),
      );
  }
}
