
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:travel_app/model/fav_model.dart';

class Favorite extends StatefulWidget {
  final String? userId;

  const Favorite({Key? key, this.userId}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Box<FavModel>? favBox;
  List<FavModel>? favboxList;

  @override
  void initState() {
    super.initState();
    favBox = Hive.box<FavModel>('favorite');
    favboxList = favBox!.values.toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Favorites")),
      body: favboxList!.isEmpty
          ? const Center(
              child: Text(
                "No favorites yet.",
                style: TextStyle(fontSize: 17),
              ),
            )
          : ListView.builder(
              itemCount: favboxList!.length,
              itemBuilder: (context, index) {
                FavModel favorite = favboxList![index]; 
                return ListTile(
                  leading: SizedBox(
                    width: 90,
                    height: 90, 
                    child: ClipRRect(
                      borderRadius:const BorderRadius.all(Radius.circular(10)),
                       child: InstaImageViewer(
                        child: Image.file(File(favorite.image!,),
                        fit:BoxFit.cover
                        ,)
                        )
                        ),
                  ),
                  title: Text(favorite.name!),
                  subtitle: Text(favorite.location!),
                  trailing: IconButton(
                    onPressed: () {
                      favBox!.delete(favorite.placekey);
                      setState(() {
                        favboxList!.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.favorite, color: Colors.amber),
                  ),
                );
              },
            ),
    );
  }
}
