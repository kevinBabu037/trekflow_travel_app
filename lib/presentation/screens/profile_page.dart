
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/data/model/profilemodel.dart';
import 'package:travel_app/presentation/fav&comments/favorite.dart';
import 'package:travel_app/presentation/screens/about_page.dart';
import 'package:travel_app/presentation/screens/edit_sheduled_details.dart';
import 'package:travel_app/presentation/screens/privacy.dart';
import 'package:travel_app/presentation/screens/profile_edit.dart';
import 'package:travel_app/presentation/widgets/reuseable_widgets.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
    Profile({super.key,required this.userid});
  String? userid;
  

  @override
  State<Profile> createState() => _ProfileState();
} 
class _ProfileState extends State<Profile> {
       
late Box<ProfileModel> profileBox ;
    String? loggedInUsername;
    String? loggedInUserId; 
     @override
   void initState() {
    super.initState();
    loadUsername();
    profileBox = Hive.box<ProfileModel>('profile');
  }
  
  
  @override
  Widget build(BuildContext context) { 
    debugPrint('user id in profile page:${widget.userid}');
    return Scaffold(
      backgroundColor:const Color.fromARGB(10, 255, 193, 7),
      appBar: AppBar( 
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title:const Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
             Text('Profile ',style: TextStyle(fontSize: 25),), 
             Icon(Icons.person,color: Colors.amber,size: 27,)
             ]),
      ),
      body:Padding(padding:const EdgeInsets.all(18), 
        child: ScrollConfiguration(
          behavior:const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(children: [
                 Container( 
                  padding:const EdgeInsets.all(20),
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(25), 
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ 
                    Stack(
                      children: [
                        SizedBox(
                          height: 90,
                          width: 100 ,
                          child: ClipRRect( 
                            borderRadius: BorderRadius.circular(15),
                           child:profileBox.isNotEmpty
                                  ? InstaImageViewer(child: Image.file(File(profileBox.getAt(0)!.image.toString()), fit: BoxFit.cover,))   
                                  : Image.asset('images/placeholder.png', fit: BoxFit.cover,),    
                          )
                        ),
                        Positioned(bottom: 0,right: 0, 
                          child: IconButton(onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(userid: widget.userid),));
                                           },
                                            icon:const Icon(Icons.add_a_photo_outlined,color: Colors.white,)),
                        )
                      ],
                    ),
                     
                     Flexible(child: Text(loggedInUsername??'',style:const TextStyle(fontSize:22 ),)),
                    const Icon(Icons.abc,color: Colors.white,)
                      
                  ],),
                 ),
          
                 profileItems(icon: Icons.favorite, text:'F a v o u r i t e',ontap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) =>const Favorite() ,));
                 },),
        
                 profileItems(icon: Icons.list_alt_rounded, text:'S c h e d u l e d  L i s t',ontap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>const EditSheduledDetails() ,));
                 },),
                 profileItems(icon: Icons.share_rounded, text:'S h a r e',ontap: () {
                  Share.share('https://www.amazon.com/dp/B0CQQTQP7K/ref=apps_sf_sta');
                 },),

                 profileItems(icon: Icons.privacy_tip_rounded, text: 'P r i v a c y  P o l i c y',ontap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) =>const PrivacyPolicy() ,));
                 },), 
                 profileItems(icon: Icons.info_rounded, text:'A b o u t',ontap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) =>const AboutPage() ,));
                 },),
                 profileItems(icon: Icons.logout_rounded, text:'L o g  O u t',ontap: () {
                   singOut(context);
                 },),
                 
                sizedBox(height: 20),  
            ],),
          ),
        ),
      )
    );
  }
  Future<void> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedInUsername = prefs.getString('loggedInUsername') ?? ''; 
    setState(() {}); 
  } 
}




