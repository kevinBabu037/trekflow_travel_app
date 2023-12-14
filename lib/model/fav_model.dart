import 'package:hive_flutter/adapters.dart';
part 'fav_model.g.dart';

@HiveType(typeId: 3)
class FavModel{
 @HiveField(0)
 String? name;

 @HiveField(1)
 String ?location;

 @HiveField(2)
 String? placekey;

 @HiveField(3)
 String? userId;

  @HiveField(4)
 String? image;

 FavModel({required this.name, this.location, this.placekey, this.userId,required this.image});

}