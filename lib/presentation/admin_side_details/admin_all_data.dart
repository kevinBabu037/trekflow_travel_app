import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:travel_app/data/model/admin_model.dart';
import 'package:travel_app/presentation/admin_side/editing_admindata.dart';
import 'dart:io';
import 'package:travel_app/presentation/widgets/reuseable_widgets.dart';


class AdminAllData extends StatefulWidget { 
  const AdminAllData({super.key,});
  

  @override
  State<AdminAllData> createState() => _AdminAllDataState();
}

class _AdminAllDataState extends State<AdminAllData> {
 
  late Box adminBox;
  @override
  void initState() { 
    super.initState();
    adminBox = Hive.box<AdminModel>('admin'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title:const Row(mainAxisAlignment: MainAxisAlignment.center, children: [ Text('All Places'),Icon(Icons.place,color: Colors.amber,)]), 
      ),
      body: ListView.separated(
      itemBuilder: (context, index) {
        final data = adminBox.getAt(index) as AdminModel;
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  userSideDisplayAllDatas(
          context: context,
          placeName: data.placeName,
          location: data.location, 
          discription: data.discription, 
          img1: data.imgUrl,
          img2: data.imgUrl1,
          img3: data.imgUrl2,
          img4: data.imgUrl3,
          placeId: data.placeKey
          )));
          }, 
          child: ListTile(
              leading: SizedBox(
           width: 80,
           height: double.infinity,
           child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InstaImageViewer(child: FadeInImage(placeholder:const AssetImage('images/placeholder.png') ,
            image: FileImage(File(data.imgUrl,),),fit:BoxFit.cover ,)),
            ),
              ),
              title: Text(data.placeName),
              subtitle: Text(data.location),
              trailing:SizedBox(
                width: 100,
                child: Row( mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditPlaceDetails(editDetails: data, ),));
                    },
                     icon:const Icon(Icons.edit,size: 20,)), 
                    IconButton(onPressed:(){
                             warnningAleartMsg(
                    context: context,
                     title: 'Delete', 
                              content:'Are you sure want to Delete',
                               onYesPressed: (){
                    adminBox.deleteAt(index);
                    setState(() {});
                     Navigator.pop(context); 
                               });
                            
                    } , 
                    icon:const Icon(Icons.delete,size: 20,)),
                  ],
                ),
              ),
          ),
        );
      },
      separatorBuilder: (context, index) =>const Divider(),
      itemCount: adminBox.length,
      ),
 
    );
  }

 
  


}