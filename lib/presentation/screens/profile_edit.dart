import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/data/model/profilemodel.dart';
import 'package:travel_app/presentation/widgets/reuseable_widgets.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
   EditProfile({super.key,required this.userid});
  String? userid;
   

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
XFile? pic;
final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title:const Text("Edit Profile"),
      ),
      body: Padding(padding:const EdgeInsets.all(10), 
        child: Form(
          key: _formKey, 
          child: Column(
            children: [
              sizedBox(height: 25), 
              InkWell(
                onTap: () {
                  profileImageTaking();
                },
                child: Container( 
                  child: pic!=null ?
                    Center(
                      child: Image.file(File(pic!.path,),fit: BoxFit.cover,height: double.infinity,width: double.infinity,),
                    )
                  :const Center(
                    child:const Icon(Icons.add_a_photo_outlined,size: 40,color: Colors.amber,), 
                  ),
                  height: 150,
                  width: 150, 
                  decoration:BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)
                  ) ,
                ),
              ),
              sizedBox(height: 25), 
              OutlinedButton(onPressed: (){
                editingFunction();
              },
               child:const Text('Save Changes'))
            ],
          ),
        ),
      ),
    );
  }

   profileImageTaking() async {
    // ignore: invalid_use_of_visible_for_testing_member
    final image = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);

       {setState(() {
        pic = XFile(image!.path);
      });
  } 
} 


editingFunction()async{
  Box<ProfileModel> profileBox = Hive.box<ProfileModel>('profile');
  if( pic!=null){
    String? key=DateTime.now().microsecondsSinceEpoch.toString();
     profileBox. put(widget.userid.toString(), ProfileModel(image:pic!.path , key:key.toString() ));
     showSnackBar(context: context, message: 'Image Added', snakBarclr: Colors.green);
     Navigator.pop(context);
     setState(() {});
  }else{
    showSnackBar(context: context, message: 'choose a image', snakBarclr: Colors.red);
  }
}
  
  
}

