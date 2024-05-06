
import 'package:hive_flutter/adapters.dart';
part 'admin_model.g.dart';

@HiveType(typeId: 1)
class AdminModel{

    @HiveField(0) 
   String imgUrl;
    
    @HiveField(1)
   String placeName;
   
   @HiveField(2)
   String location;
    
    @HiveField(3)
   String discription;

    @HiveField(4)
   String imgUrl1;

    @HiveField(5)
   String imgUrl2;

    @HiveField(6)
   String imgUrl3;

   @HiveField(7)
   String? catagorys;

    @HiveField(8)
    List<String>? review;

   @HiveField(9)
   String placeKey;

   @HiveField(10)
   String? userId;

   AdminModel({required this.imgUrl,
   required this.placeName,
   required this.location,
   required this.discription,
   required this.imgUrl1,
   required this.imgUrl2,
   required this.imgUrl3,
    this.catagorys, 
    required this.placeKey,
     this.review,
     this.userId,
   });
}