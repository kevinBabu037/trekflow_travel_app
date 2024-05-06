

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/data/model/comment.dart';
import 'package:travel_app/data/model/profilemodel.dart';
import 'package:travel_app/data/model/shedule_model.dart';
import 'package:travel_app/presentation/login/login_screen.dart';

Widget appNAme(){
  return const Align(
    child:  Text('TrekFlow',
    style: TextStyle(
      fontSize: 50,
      color: Colors.amber,
      fontWeight: FontWeight.bold),));
}

Widget appNameDownTxt(){
  return const Text('- I F   N O T   N O W,   W H E N ? -',
  style: TextStyle(color: Colors.amber,fontSize:13),);

}

Widget sizedBox({double? height,double? width }){
  return SizedBox(
    height:height,
    width: width,
  );
}


Widget trentingPlacesNow({
  required String imageUrl,
  required void Function()  buttonAction ,
   required String placeName
}){
  return  Stack(
     children: [
     SizedBox(
      child: ClipRRect(
        child: InstaImageViewer(
          child: FadeInImage(
            placeholder:const AssetImage('images/placeholder.png'),
            image: NetworkImage(
              imageUrl,
            ),
             fit: BoxFit.cover,
          ),
        ),
        borderRadius: BorderRadius.circular(30 ),
      ),
      height: 600,
      width: 330,
    ),


    Positioned( 
      right: 0,
      left: 0 ,
      top: 10,
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(placeName,style:const TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold,color: Colors.white),)
      ],
    )),
      
    Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width:100,
            child: ClipRRect(
               borderRadius: BorderRadius.circular(100), 
               child: ElevatedButton(
                onPressed: buttonAction,
                child: const Text('Details',style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
);

}


Widget trentingPlaceDetails({
  required String placeName,
  required String location,
  required String img1,
  required String img2,
  required String img3,
  required String img4,
  required String descriptionTxt
}){
  
  return Scaffold(
    appBar: AppBar(actions: [sizedBox(width: 47)],
      centerTitle: true,
      elevation: 0, 
      backgroundColor: Colors.white,
      title:
         Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(placeName,style:const TextStyle(fontWeight: FontWeight.w400) ,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Icon( Icons.location_on,color: Colors.amber,),
                Text(location,style:const TextStyle(fontWeight: FontWeight.w400,color: Colors.grey,fontSize: 17),), 
                ])
        ],),
      ),
       
       body: Column( 
         children: [
           AspectRatio(aspectRatio:1,
             child: ScrollConfiguration(
              behavior:const ScrollBehavior().copyWith(overscroll: false),
               child: GridView(
                padding:const EdgeInsets.all(15),
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 10/10   
                  ),
                   
                   children: [ 
                         InstaImageViewer(
                         child:ClipRRect(borderRadius: BorderRadius.circular(10),
                         child: FadeInImage(placeholder:const AssetImage('images/placeholder.png'),image: NetworkImage(img1),fit: BoxFit.cover,)) ),
                         InstaImageViewer(
                         child:ClipRRect(borderRadius: BorderRadius.circular(10),
                         child: FadeInImage(placeholder:const AssetImage('images/placeholder.png'),image: NetworkImage(img2),fit: BoxFit.cover,)) ),
                         InstaImageViewer(
                         child:ClipRRect(borderRadius: BorderRadius.circular(10),
                         child: FadeInImage(placeholder:const AssetImage('images/placeholder.png'),image: NetworkImage(img3),fit: BoxFit.cover,)) ),
                         InstaImageViewer(
                         child:ClipRRect(borderRadius: BorderRadius.circular(10),
                         child:FadeInImage(placeholder:const AssetImage('images/placeholder.png'),image: NetworkImage(img4),fit: BoxFit.cover,)) ),
                       
                   ],
                        
                ),
             ),
           ),

            Expanded(
              child: ScrollConfiguration(behavior:const ScrollBehavior().copyWith(overscroll: false),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        sizedBox(height: 15),
                        const Text('Description',style: TextStyle(fontSize: 20),),
                        Padding(padding:const EdgeInsets.all(20), 
                          child: SizedBox(
                                child: Text(descriptionTxt,style:const TextStyle(fontSize: 15),),
                               ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              
              )
                  
         ],
       ),


  );

}

 


sheduledAllDatas({
  required String details,
  required data
}){
return Row(children: [ 
   Text(details,style:const TextStyle(fontSize: 17),),
   Text(data,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)],);
}



singOut(BuildContext context){
  showDialog(context: context,   builder: (context) {
    return AlertDialog(
       title:const Text('Logout'),
      content:const Text('you want to log out?'), 
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        },
         child: const Text('cancel')),
         TextButton( onPressed: () async {
           Box profilebox=Hive.box<ProfileModel>('profile');
           Box sheduleBox=Hive.box<SheduleTripMode>("sheduleTrip");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', false);
                Navigator.pushAndRemoveUntil( 
                context,
                MaterialPageRoute(builder: (context) =>const LoginPage()),
                (route) => false,
                
              );
              if(profilebox.isNotEmpty){
                profilebox.clear();  
              }
              if(sheduleBox.isNotEmpty){
                sheduleBox.clear();
              }
              
    
            },  
          child: const Text('Yes'))
      ],
    );
  },);
 }

 warnningAleartMsg({
  required BuildContext context,
   required String title,
   required String content,
   required VoidCallback? onYesPressed,
   }){
   showDialog(context:context,   builder: (context) {
    return AlertDialog(
       title: Text(title),
      content: Text(content), 
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        },
         child: const Text('cancel')),
         TextButton( onPressed: onYesPressed ,
        
          child: const Text('Yes')),
          
          
      ],
    );
  },);
 }



 Widget profileItems({
  required IconData icon,
  required String text,
  void Function()? ontap, 
 }){
  return Container(padding:const EdgeInsets.only(left: 15,right: 15 ),
              margin:const EdgeInsets.only(top: 13,), 
              height: 80 ,
              width: double.infinity,
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(16),
                color: Colors.white, 
              ),
              child: Row(children: [
                InkWell(onTap: ontap, child: Icon(icon,color: Colors.amber,size: 30,)),
                sizedBox(width:10 ),
                InkWell(onTap: ontap, child: Text(text,style:const TextStyle(fontSize: 20 ) ,)),
              ],),
             );
 }


Widget userSideDisplayAllDatas({
  required BuildContext context,
  required String placeName,
  required String location,
    required String discription,
    required String img1,
     required String img2,
      required String img3,
       required String img4,
       required String placeId,
}){
   return Scaffold(
       appBar: AppBar(actions: [sizedBox(width: 47)],
      centerTitle: true,
      elevation: 0, 
      backgroundColor: Colors.white,
      title:
         Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(placeName,style:const TextStyle(fontWeight: FontWeight.w400) ,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Icon( Icons.location_on,color: Colors.amber,),
                Text(location,style:const TextStyle(fontWeight: FontWeight.w400,color: Colors.grey,fontSize: 17),), 
                ])
        ],),
      ), 
     body: Column(
      children: [ 
         AspectRatio(aspectRatio:10/9.3 ,
           child: ScrollConfiguration(behavior:const ScrollBehavior().copyWith(overscroll: false),
             child: GridView(
              padding:const EdgeInsets.all(15),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 10/9  
                ),
                  
                 children: [ 
                       InstaImageViewer(
                       child:ClipRRect(borderRadius: BorderRadius.circular(10), 
                       child: FadeInImage(placeholder:const AssetImage('images/placeholder.png'),
                        image: FileImage(File(img1)),fit: BoxFit.cover,)) ),
                        InstaImageViewer(
                       child:ClipRRect(borderRadius: BorderRadius.circular(10), 
                       child: FadeInImage(placeholder:const AssetImage('images/placeholder.png'),
                        image: FileImage(File(img2)),fit: BoxFit.cover,)) ),
                        InstaImageViewer(
                       child:ClipRRect(borderRadius: BorderRadius.circular(10), 
                       child: FadeInImage(placeholder:const AssetImage('images/placeholder.png'),
                        image: FileImage(File(img3)),fit: BoxFit.cover,)) ),
                        InstaImageViewer(
                       child:ClipRRect(borderRadius: BorderRadius.circular(10), 
                       child: FadeInImage(placeholder:const AssetImage('images/placeholder.png'),
                        image: FileImage(File(img4)),fit: BoxFit.cover,)) ),   
                 ],
                    
              ),
           ),
         ),

          
         Padding(padding:const EdgeInsets.only(left: 10,right: 10 ),
         child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween , 
          children: [const Text('Discription',
          style: TextStyle(fontSize: 20 ,color: Colors.amber),),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewDetails(placeId:placeId ),));
          },
           icon:const Icon(Icons.comment ,color: Colors.amber,size: 28,)) 
          ],)),
         Expanded(child:  ScrollConfiguration(behavior:const ScrollBehavior().copyWith(overscroll: false) ,
           child: ListView(
            padding:const EdgeInsets.only(right: 10,left: 10),
            children: [
             sizedBox(height: 10,),
            Text(discription,style:const TextStyle(fontSize: 15.5)),
            ],
                 ),
         ))
      ],
     ),
    );
 }





Widget catagorysFiltering({
 required String title,
  bool isSelected = false
}){
  return   Container(
    
                    child: Center(
                      child: Text(title,style: const TextStyle(fontSize: 15 ,fontWeight: FontWeight.w400,),),
                    ),
                    margin:const EdgeInsets.only(right: 7 ),
                    width: 100, 
                    decoration: BoxDecoration( 
                    color: isSelected ? const Color.fromARGB(93, 255, 193, 7) : Colors.white,                      borderRadius: BorderRadius.circular(10  )
                      ), 
                  );                  
} 



TextFormField buildTextFormField({
  required TextEditingController controller,
  required String labelText,
   Function (String?)? onSaved,
  required String? Function(String?) validator,
  required Function(String) onChanged,
  bool? hidepassword=false,
  IconData? eyeIcon,
}) {
  return TextFormField(
    obscureText:hidepassword!,
    controller: controller,
    onSaved: onSaved,
    validator: validator,
    onChanged: onChanged,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      suffixIcon:IconButton(
        onPressed: (){}, 
      icon: Icon(eyeIcon) 
      ),
      border: OutlineInputBorder(   
        borderRadius: BorderRadius.circular(50),
      ),
      labelText: labelText,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: Colors.amber,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: Colors.amber,
          width: 2,
        ),
      ),
    ),
  );
}
 

 const String aboutText='''Our travel app allows users to discover and select their favorite destinations, schedule trips, utilize search and filter functionality, and enjoy an enhanced user profile experience, while administrators can seamlessly add new places, creating a comprehensive and personalized travel platform. 

The travel app is a comprehensive platform designed to offer users a seamless and personalized travel experience. At its core, the app empowers users to explore a diverse array of destinations, providing them with the tools to curate their travel preferences, plan and schedule trips, and connect with a community of fellow travelers. With a user-friendly interface, the app aims to enhance the overall travel journey from exploration to execution.

One of the primary features of the app is the ability for users to choose from a vast selection of places. Whether it's a bustling city, a tranquil beach, or a picturesque mountain retreat, the app caters to a variety of preferences. Users can browse through detailed descriptions, captivating images, and relevant information to make informed decisions about their desired destinations.

To further personalize their experience, users can mark specific places as favorites. This feature allows individuals to create a curated list of preferred destinations, fostering a sense of connection and ownership over their travel choices. The favorite places feature not only serves as a quick reference for users but also adds a layer of personalization to their overall travel profile within the app.

The app goes beyond mere destination selection by empowering users to plan and schedule their trips. The trip scheduling feature enables users to set dates, add activities, and organize their itinerary, ensuring a well-structured and memorable travel experience. This functionality is geared towards streamlining the planning process and providing users with a convenient tool to manage their trips efficiently.

 ''';

 const String privacyPlolicyText='''Privacy Policy
Kevin built the trekFlow app as a Free app. This SERVICE is provided by Kevin at no cost and is intended for use as is.

This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.

If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.

The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at trekFlow unless otherwise defined in this Privacy Policy.

Information Collection and Use

For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.

The app does use third-party services that may collect information used to identify you.

Link to the privacy policy of third-party service providers used by the app

Google Play Services
Log Data

I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.

Cookies

Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

Service Providers

I may employ third-party companies and individuals due to the following reasons:

To facilitate our Service;
To provide the Service on our behalf;
To perform Service-related services; or
To assist us in analyzing how our Service is used.
I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

Security

I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.

Links to Other Sites

This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.

Children’s Privacy

These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.

Changes to This Privacy Policy

I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.

This policy is effective as of 2023-12-10

Contact Us

If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at kevinbabu@gmail.com.''';


 class ReviewDetails extends StatefulWidget {
 const ReviewDetails({super.key, required this.placeId});
  final String placeId;

  @override
  State<ReviewDetails> createState() => _ReviewDetailsState();
}

class _ReviewDetailsState extends State<ReviewDetails> {
  TextEditingController comment = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<dynamic> comments = [];
  Box<CommentModel> commentBox = Hive.box<CommentModel>('comment');

  @override
  void initState() {
    super.initState();
    loadComments();
  }
   void loadComments() {
    setState(() {
      // Filter comments based on the selected place ID
      comments = commentBox.values.where((comment) => comment.placeId == widget.placeId).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        elevation: 0, 
        backgroundColor: Colors.white,
        title:const Text('comments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: comment,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Comments',
                  suffixIcon: IconButton(
                    onPressed: () {
                    commentAdding();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
              ),
             const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.chat, size: 20, color: Colors.amber),
                     title: Text(comments[index].comment),                     
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: comments.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

void commentAdding() {
    if (_formKey.currentState!.validate()) {
      CommentModel newComment = CommentModel(placeId: widget.placeId, comment: comment.text);
      commentBox.add(newComment);
      loadComments(); 
      comment.clear();
    }
  }
}
    
adminSingOut(BuildContext context){
  showDialog(context: context,   builder: (context) {
    return AlertDialog(
       title:const Text('Logout'),
      content:const Text('you want to log out?'), 
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        },
         child: const Text('cancel')),
         TextButton( onPressed: () async {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const LoginPage() ,), (route) => false);
            }, 
          child: const Text('Yes'))
      ],
    );
  },);
 }


 void showSnackBar({required context, required String? message, required Color?  snakBarclr}) {
  ScaffoldMessenger.of(context??'').showSnackBar(
    SnackBar(
      content: Text(message!),
      backgroundColor: snakBarclr
    ),
  );
}
  



 