import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/data/model/admin_model.dart';
import 'package:travel_app/presentation/admin_side/admin_all_data.dart';
import 'package:travel_app/data/functions/hive_functions.dart';
import 'package:travel_app/presentation/widgets/reuseable_widgets.dart';





class EditPlaceDetails extends StatefulWidget {
  final AdminModel editDetails;
  
   const EditPlaceDetails({super.key ,required  this.editDetails });

  @override
  State<EditPlaceDetails> createState() => _AdminDataAddingPageState();
}

class _AdminDataAddingPageState extends State<EditPlaceDetails> {
    String? _placeName;

     String? _location; 

     String? _discription;

     XFile? _image; 
     XFile? _image1;
     XFile? _image2; 
     XFile? _image3; 
     String _selectedValue='All';
      List<String> items=[
      'All',
      'Hill Stations',
      'Beaches',
      'Water Falls',
      'Forest',
      'Desert',
     ];

     late Box adminBox;

     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

      TextEditingController placeNameController=TextEditingController();

      TextEditingController locationController=TextEditingController();

      TextEditingController discriptionController=TextEditingController();

 

 @override
  void initState() {
    super.initState();
     placeNameController = TextEditingController(text: widget.editDetails.placeName);
     locationController = TextEditingController(text: widget.editDetails.location);
     discriptionController = TextEditingController(text: widget.editDetails.discription);
     _image = XFile(widget.editDetails.imgUrl);
     _image1 = XFile(widget.editDetails.imgUrl1);
     _image2 = XFile(widget.editDetails.imgUrl2);
     _image3 = XFile(widget.editDetails.imgUrl3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor:Colors.white,
        
        title:const Text("Admin"),
      ), 
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [  
                const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Edit Details',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300)),Icon(Icons.place,color: Colors.amber,)]),
          
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
                   updatePlaceDetails();
                  },
                   icon:const Icon(Icons.update),
                    label:const Text('Update',style: TextStyle(color: Colors.black ),))
              ],
            ),
          ),
        ),
      ),
    );
  }


 ///////////functions///////////////

void updatePlaceDetails() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      // Update the data in Hive
      final updatedDetails = AdminModel(
        placeKey: widget.editDetails.placeKey,
        imgUrl: _image?.path ?? widget.editDetails.imgUrl,
        placeName: _placeName ?? widget.editDetails.placeName,
        location: _location ?? widget.editDetails.location,
        discription: _discription ?? widget.editDetails.discription,
        imgUrl1: _image1?.path ?? widget.editDetails.imgUrl1,
        imgUrl2: _image2?.path ?? widget.editDetails.imgUrl2,
        imgUrl3: _image3?.path ?? widget.editDetails.imgUrl3,
        catagorys: _selectedValue 
      );

      // Use the update function from the HiveFunctions file
      HiveFunctions.updateAdminModel(Hive.box<AdminModel>('admin'), widget.editDetails, updatedDetails);

      showSnackBar(context: context, message: 'Updated Successfully', snakBarclr: Colors.green);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const AdminAllData(),));
    }
  }

  getImage()async{
    // ignore: invalid_use_of_visible_for_testing_member
    final image=await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
    setState(() {
      _image=image; 
    });
  }
  getImage1()async{
    // ignore: invalid_use_of_visible_for_testing_member
    final image=await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
    setState(() {
      _image1=image;
    });
  }

  getImage2()async{
    // ignore: invalid_use_of_visible_for_testing_member
    final image=await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
    setState(() {
      _image2=image;
    });
  }

  getImage3()async{
    // ignore: invalid_use_of_visible_for_testing_member
    final image=await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
    setState(() {
      _image3=image;
    });
  }

 
  }


  