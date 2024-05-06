import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/data/model/admin_model.dart';
import 'package:travel_app/data/model/fav_model.dart';
import 'package:travel_app/presentation/widgets/reuseable_widgets.dart';
import 'all_details.dart';

class PlacesList extends StatefulWidget {
  const PlacesList({super.key});
  @override
  State<PlacesList> createState() => _PlacesListState();
}
class _PlacesListState extends State<PlacesList> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  late Box<FavModel>? favbox;
  late Box adminBox;
   AdminModel? dataoffavourite;
  @override
  void initState() {
    super.initState();
    adminBox = Hive.box<AdminModel>('admin');
    favbox = Hive.box<FavModel>('favorite');
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('All Places', style: TextStyle(fontSize: 25)),
            Icon(Icons.place, color: Colors.amber, size: 27),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: onSearchTextChanged,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: AspectRatio(
              aspectRatio: 100 / 9,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = 'All';
                      });
                    },
                    child: catagorysFiltering(title: 'All', isSelected: _selectedCategory == 'All'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = 'Beaches';
                      });
                    },
                    child: catagorysFiltering(isSelected: _selectedCategory == 'Beaches', title: 'Beaches'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = 'Hill Stations';
                      });
                    },
                    child: catagorysFiltering(isSelected: _selectedCategory == 'Hill Stations', title: 'Hill Station'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = 'Water Falls';
                      });
                    },
                    child: catagorysFiltering(isSelected: _selectedCategory == 'Water Falls', title: 'Water falls'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = 'Forest';
                      });
                    },
                    child: catagorysFiltering(isSelected: _selectedCategory == 'Forest', title: 'Forest'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = 'Desert';
                      });
                    },
                    child: catagorysFiltering(isSelected: _selectedCategory == 'Desert', title: 'Desert'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: adminBox.isEmpty
                ? const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "List is empty",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final filteredData = filterDataByCategory(_selectedCategory)
                          .where((data) =>
                              data.placeName.toLowerCase().contains(_searchQuery) ||
                              data.location.toLowerCase().contains(_searchQuery))
                          .toList();
                      final data = filteredData[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(placeDetails: data)));
                        },
                        child: ListTile(
                          leading: SizedBox(
                            width: 80,
                            height: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: InstaImageViewer(
                                child: FadeInImage(
                                  placeholder: const AssetImage('images/placeholder.png'),
                                  image: FileImage(File(data.imgUrl)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ), 
                          ),
                          title: Text(data.placeName, style: const TextStyle(fontSize: 18)),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.place, size: 16, color: Color.fromARGB(150, 255, 193, 7)),
                              Text(' ${data.location}', style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                            toggleFavorite(data);
                            },
                            icon:Icon(
                               favbox?.containsKey(data.placeKey) ?? false
                                ? Icons.favorite
                                : Icons.favorite_border,
                                 color: favbox?.containsKey(data.placeKey) ?? false
                                 ? Colors.amber
                                 : Colors.grey, 
                          ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: filterDataByCategory(_selectedCategory)
                        .where((data) =>
                            data.placeName.toLowerCase().contains(_searchQuery) ||
                            data.location.toLowerCase().contains(_searchQuery))
                        .length,
                  ),
          ),
        ],
      ),
    );
  }

  ////////function///////

  void onSearchTextChanged(String value) {
    setState(() {
      _searchQuery = value.toLowerCase();
    });
  }
  
  List<AdminModel> filterDataByCategory(String category) {
    if (category == 'All') {
      // If 'All' is selected, return all data
      return List<AdminModel>.from(adminBox.values.cast<AdminModel>());
    } else {
      // Filter data based on the selected category
      return adminBox.values.whereType<AdminModel>().where((data) => data.catagorys == category).toList();
    }
  }
 
 Future<AdminModel> toggleFavorite(AdminModel data) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    String userKey = prefs.getString('loggedInUserId').toString();
    String placeKey = data.placeKey;
    debugPrint('checking hasss user id in places page: $userKey');

    // Check if the item is already in favorites
    bool isFavorite = favbox?.containsKey(placeKey) ?? false;
    setState(() {
      if (isFavorite) {
        // If it's in favorites, remove it
        favbox?.delete(placeKey);
      } else {
        // If it's not in favorites, add it
        favbox?.put(
          placeKey,
          FavModel(
            image: data.imgUrl,
            name: data.placeName,
            location: data.location,
            placekey: data.placeKey,
            userId: userKey,
          ),
        );

      }
    });
    return data;
  } catch (e) {
    debugPrint('Error toggling favorite: $e');
    // Handle the error as needed (show a message, log it, etc.)
    return data;
  }
}


    
}
