import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/functions/hive_functions.dart';
import 'package:travel_app/model/admin_model.dart';
import 'package:travel_app/reuseable_widgets/reuseable_widgets.dart';

class AdminDataAddingPage extends StatefulWidget {
   const AdminDataAddingPage({super.key});

  @override
  State<AdminDataAddingPage> createState() => _AdminDataAddingPageState();
}
class _AdminDataAddingPageState extends State<AdminDataAddingPage> { 
     String? _placeName;
     String? _location; 
     String? _discription;
     XFile? _image; 
     XFile? _image1;
     XFile? _image2; 
     XFile? _image3;
     String _selectedValue='All';
     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
     final TextEditingController placeNameController=TextEditingController();
     final TextEditingController locationController=TextEditingController();
     final TextEditingController discriptionController=TextEditingController();
        
     List<String> items=[
      'All',
      'Hill Stations',
      'Beaches',
      'Water Falls',
      'Forest',
      'Desert',
     ];
   
   Box adminBox=Hive.box<AdminModel>('admin');
   
  @override
  Widget build(BuildContext context) { 
    return GestureDetector(
      onTap: () {
         FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor:Colors.white,
          actions: [
            IconButton(
              onPressed: (){
               adminSingOut(context);
              },
              icon:const Icon(Icons.logout)
               )],
          title:const Text("Admin"),
        ), 
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [  
                  const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Add Place',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300)),Icon(Icons.place,color: Colors.amber,)]),
            
                   Row(
                     children: [
                       Expanded(
                         child: Container( 
                          margin:const EdgeInsets.only(top: 10),
                          height: 180 ,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()   
                          ),
                          child: InkWell(
                            onTap: () { 
                             getImage();
                            }, 
                           child: _image != null
                             ? Image.file(File(_image!.path), fit: BoxFit.fill,)
                              : const Center(
                               child: Icon(Icons.add_a_photo, size: 35, color: Colors.black45,),
                               ),     
                          ),
                         ),
                       ),
                         sizedBox(width: 10),
    
                         Expanded(
                           child: Container( 
                                               margin:const EdgeInsets.only(top: 10),
                                               height: 180 ,
                                               decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()   
                                               ),
                                               child: InkWell(
                            onTap: () { 
                             getImage1();
                            }, 
                           child: _image1!= null
                             ? Image.file(File(_image1!.path), fit: BoxFit.fill,)
                              : const Center(
                               child: Icon(Icons.add_a_photo, size: 35, color: Colors.black45,),
                               ),     
                                               ),
                                              ),
                         ),
                     ],
                   ),
    
                    
                    Row(children: [
                        Expanded(
                         child: Container( 
                          margin:const EdgeInsets.only(top: 10),
                          height: 180 ,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()   
                          ),
                          child: InkWell(
                            onTap: () { 
                             getImage2();
                            }, 
                           child: _image2!= null
                             ? Image.file(File(_image2!.path), fit: BoxFit.fill,)
                              : const Center(
                               child: Icon(Icons.add_a_photo, size: 35, color: Colors.black45,),
                               ),     
                          ),
                         ),
                       ),
                         sizedBox(width: 10), 
    
                         Expanded(
                           child: Container( 
                                               margin:const EdgeInsets.only(top: 10),
                                               height: 180 ,
                                               decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()   
                                               ),
                                               child: InkWell(
                            onTap: () { 
                             getImage3();
                            }, 
                           child: _image3!= null
                             ? Image.file(File(_image3!.path), fit: BoxFit.fill,)
                              : const Center(
                               child: Icon(Icons.add_a_photo, size: 35, color: Colors.black45,),
                               ),     
                                               ),
                                              ),
                         ),
                    ],),
            
                    sizedBox(height: 10),
    
                   SizedBox(         
                     child: Row(
                       children: [  
                        const Text('Select category   ',style: TextStyle(fontSize:19,color: Colors.amber  ),), 
                           DropdownButton<String>(
                             iconSize: 30,
                           style: const TextStyle(fontSize: 17, color: Colors.black),
                            value: _selectedValue,
                           items: items.map((item) => DropdownMenuItem<String>(
                            value: item,
                             child: Text(item),
                            )).toList(),
                                onChanged: (String? item) {
                           setState(() => _selectedValue = item!);
                              },
                               ),
                         ],
                     ),
                   ),
    
                    sizedBox(height: 10),
                      TextFormField(
                    onSaved:(newValue) {
                      _placeName=newValue;
                    }, 
                    validator: (value) {
                     if(value==null||value.isEmpty){
                      return 'required';
                     } return null;
                    },
                    controller: placeNameController,
                   decoration:const InputDecoration(
                    hintText: 'Place Name ',
                    border: OutlineInputBorder() 
                   ),
                  ),
                  sizedBox(height: 20),
                  TextFormField(
                    onSaved: (newValue) {
                      _location=newValue;
                    },
                    validator: (value) {
                     if(value==null||value.isEmpty){
                      return 'required';
                     } return null;
                    },
                    controller: locationController,
                    decoration:const InputDecoration(
                      hintText: 'Place Location',
                    border: OutlineInputBorder() 
                   ),
                  ),
                  sizedBox(height: 20),
                  TextFormField(
                    maxLines: 5,
                    onSaved: (newValue) {
                      _discription=newValue;
                    },
                    validator: (value) {
                     if(value==null||value.isEmpty){
                      return 'required';
                     } return null;
                    },
                    controller: discriptionController,
                    decoration:const InputDecoration(
                      hintText: 'Place Discription',
                    border: OutlineInputBorder() 
                   ),
                  ),
                  sizedBox(height: 30),
  
                   OutlinedButton.icon(
                    onPressed: (){
                      addingAdminData();
                        
                    },
                     icon:const Icon(Icons.add),
                      label:const Text('Add Place',style: TextStyle(color: Colors.black ),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  ////////functions/////////////

 addingAdminData() {
  final isValid = _formKey.currentState?.validate();
  if (isValid != null && isValid) {
    _formKey.currentState?.save(); 
    String key = DateTime.now().millisecondsSinceEpoch.toString();
    if (_image != null&&_image1!=null&&_image2!=null&&_image3!=null) {
      adminBox.put(key,AdminModel(
        catagorys: _selectedValue,
          imgUrl: _image!.path,
          placeName: _placeName!,
          location: _location!,
          discription: _discription!,
          imgUrl1: _image1!.path,
          imgUrl2: _image2!.path,
          imgUrl3: _image3!.path,
          placeKey: key,
          ));
          showSnackBar(context: context, message:'Added Succesfuly',snakBarclr: Colors.green);
         resetForm();
          
    } else {
      showSnackBar(context: context, message: 'Select an image',snakBarclr: Colors.red);
    }
  }
}
  void getImage() {
    AdminDataFunctions.getImage(
      setImage: (image) {
        setState(() {
          _image = image;
        });
      },
    );
  }
  void getImage1() {
    AdminDataFunctions.getImage(
      setImage: (image) {
        setState(() {
          _image1 = image;
        });
      },
    );
  }
  void getImage2() {
    AdminDataFunctions.getImage(
      setImage: (image) {
        setState(() {
          _image2 = image;
        });
      },
    );
  }
  void getImage3() {
    AdminDataFunctions.getImage(
      setImage: (image) {
        setState(() {
          _image3 = image;
        });
      },
    );
  }
 void resetForm() {
  setState(() {
    _placeName = null;
    _location = null;
    _discription = null;
    _image = null;
    _image1=null;
    _image2=null;
    _image3=null; 
    placeNameController.clear();
    locationController.clear();
    discriptionController.clear();
  });
}



}
  