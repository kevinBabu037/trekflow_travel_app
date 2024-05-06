
import 'package:flutter/material.dart';
import 'package:travel_app/data/model/admin_model.dart';
import '../widgets/reuseable_widgets.dart';
class DetailsScreen extends StatelessWidget {
  final AdminModel placeDetails;
  const DetailsScreen({super.key, required this.placeDetails });
   


  @override
  Widget build(BuildContext context) {
    return userSideDisplayAllDatas(
      context: context,
      placeName: placeDetails.placeName,
       location: placeDetails.location,
        discription: placeDetails.discription,
        img1: placeDetails.imgUrl,
        img2: placeDetails.imgUrl1,
        img3: placeDetails.imgUrl2,
        img4: placeDetails.imgUrl3,
        placeId:placeDetails.placeKey, 
        ); 
  }
}