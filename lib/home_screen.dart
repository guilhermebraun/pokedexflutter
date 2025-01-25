import 'dart:convert'; //Converter os dados JSON da API em objetos do Dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedexflutter/pokemon_detail_screen.dart'; //Buscar os dados da API

class HomeScreen extends StatefulWidget {
  @override
 _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var pokeApi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List<dynamic> pokedex = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
              right: -50,
              child: Image.asset("images/pokeball.png", width: 200, fit: BoxFit.fitWidth,)
          ),
          Positioned(
            top: 80,
              left: 20,
              child: Text("Pokedex",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black))
          ),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
            children: [
              pokedex != null ? Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
              ), itemCount: pokedex.length,
                 itemBuilder: (context, index){
                var type = pokedex[index]['type'][0];
                return InkWell(
                  child: Card(
                    color: type == 'Grass'? Colors.greenAccent : type == 'Fire'? Colors.redAccent :
                        type == 'Water'? Colors.blue : type == 'Electric'? Colors.yellow :
                            type == "Rock"? Colors.brown : type == 'Ground'? Colors.amber :
                                type == 'Ice'? Colors.cyanAccent : type == 'Normal'? Colors.grey :
                                    type == 'Dragon'? Colors.orange : type == 'Psychic'? Colors.purpleAccent :
                                        type == 'Bug'? Colors.lightGreen : type == 'Poison'? Colors.purple :
                                            type == 'Fighting'? Colors.pinkAccent :  type == 'Ghost'? Colors.indigoAccent :
                                                Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -10,
                            right: -10,
                            child: Image.asset('images/pokeball.png', height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 15,
                            child: Text(
                                pokedex[index]['name'],
                                style: TextStyle(
                                  fontWeight:FontWeight.bold, fontSize: 18,
                                  color: Colors.white,
                                )
                            ),
                          ),
                          Positioned(
                              top: 40,
                              left: 15,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                  child: Text(
                                    type.toString(),
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular((12))),
                                  color: Colors.black26,
                                ),
                              ),
                          ),
                          Positioned(
                              bottom: 5,
                              right: 2,
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                    imageUrl: pokedex[index]["img"],
                                    fit: BoxFit.contain,
                                ),
                              ),
                          ),
                       ]
                      ),
                    ),
                  ),
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (_) => PokemonDetailScreen(
                       pokemonDetail: pokedex[index],
                       color: type == 'Grass'? Colors.greenAccent : type == 'Fire'? Colors.redAccent :
                       type == 'Water'? Colors.blueAccent : type == 'Electric'? Colors.yellow :
                       type == "Rock"? Colors.brown : type == 'Ground'? Colors.amber :
                       type == 'Ice'? Colors.cyanAccent : type == 'Normal'? Colors.grey :
                       type == 'Dragon'? Colors.orange : type == 'Psychic'? Colors.purpleAccent :
                       type == 'Bug'? Colors.lightGreen : type == 'Poison'? Colors.purple :
                       type == 'Fighting'? Colors.pinkAccent :  type == 'Ghost'? Colors.indigoAccent :
                       Colors.white,
                       heroTag: index,
                     )));
                  },
                );
                 },
              ),
              ): Center(
                child: CircularProgressIndicator(),
              )
            ],
                    ),
          ),
      ]
      )
    );
  }

  void fetchPokemonData(){
    var url = Uri.http("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value){
      if(value.statusCode == 200){
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData["pokemon"];
          setState(() {});
      }
    });
  }
}