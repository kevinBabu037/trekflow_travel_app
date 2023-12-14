
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/model/shedule_model.dart';
import '../reuseable_widgets/reuseable_widgets.dart';

class SheduleChanges extends StatefulWidget {
 const  SheduleChanges({super.key ,required this.sheduleBox, this.editMode=false});
  final   SheduleTripMode sheduleBox ;
  final bool editMode;

  @override
  State<SheduleChanges> createState() => _SheduleChangesState();
}

class _SheduleChangesState extends State<SheduleChanges> {

  String? destination; 
  String? startingDate;
  String? endingDate;
  List<String>companion=[];
  int? budget; 
   final _formKey=GlobalKey<FormState>();
   

   @override
 void initState() {
  super.initState();
  if (widget.editMode) {
    _destinationController.text = widget.sheduleBox.destination;
    startingDate = widget.sheduleBox.startingDate;
    endingDate = widget.sheduleBox.endingDate;
    companion = List.from(widget.sheduleBox.companion);
    _budgetController.text = widget.sheduleBox.budget.toString();
    
  }
 }
 final _destinationController=TextEditingController();
 final _budgetController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title:const Text("Edit Trip details",style: TextStyle( fontWeight: FontWeight.bold,color: Colors.black),),  
        backgroundColor: Colors.white,
        ),
      body:   SingleChildScrollView(
        
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Form(
            key: _formKey,
            child: Column(   
              
              children: [ 
                sizedBox(height: 20),
                TextFormField(
                  controller: _destinationController,
                  onSaved: (newValue) {
                    destination=newValue;
                  },
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return 'required';
                    }else if(value.length<3){
                      return 'enter Destination';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.location_on,color: Colors.amber,),
                    labelText: 'Add your destination',
                    border: OutlineInputBorder(),
                  ),
                ),
                
                sizedBox(height:20 ),
          
                  const  Row(children: [ Text('Shedule Trip',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)]), 
                
                 sizedBox(height: 15), 
              
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [InkWell(
                    onTap: () {
                      startingDatePicker();
                    },
                    child: Text("Starting Date: ${startingDate ?? 'dd-MM-yyyy'} ",
                    style:const TextStyle(fontSize: 16),),
                  ),
                  IconButton(onPressed: (){
                    startingDatePicker();
                  },
                   icon:const Icon(Icons.calendar_month,color: Colors.amber,))
                  ]),
          
                  const Divider(thickness:0.5),
                 
          
                  sizedBox(height: 10 ),
                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [InkWell(
                    onTap: () {
                      endingDatePicker();
                    },
                    child: Text("Ending Date: ${endingDate ?? 'dd-MM-yyyy'} ",
                    style:const TextStyle(fontSize: 16),),
                  ),
                  IconButton(onPressed: (){
                    endingDatePicker();
                  }, 
                  icon:const Icon(Icons.calendar_month,color: Colors.amber,))
                ]),
          
                 const Divider(thickness:0.5),
          
          
                    const Row(children: [ Text('Companions',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)]),
                     sizedBox(height:5),
                    
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                      children: [
                       InkWell(onTap: () {
                         addCompanionFromContact();
                       }, child: const Text('Select from contacts',style: TextStyle(fontSize:16 ),)),
                      IconButton(onPressed: (){
                        addCompanionFromContact();
                      },
                       icon:const Icon(Icons.contacts,color: Colors.amber,) 
                       ),
                      ],
                    ),
                    const Divider(thickness:0.5),  
          
                   sizedBox(height: 10),
          
                  AspectRatio(
                  aspectRatio:100/33,
                 child: companion.isNotEmpty ? ListView.separated(
                    itemBuilder: (context, index) {
          
                      return  Row(
                        children: [Text(" ${index+1}.  ${companion[index]}",style:const TextStyle(fontSize: 16),),
                       IconButton(onPressed: (){
                        deleteCompanion(index);
                       }, 
                       icon:const Icon(Icons.delete,size: 20,color: Colors.grey,))
                      ]);
                    },
                    separatorBuilder: (context, index) =>const Divider(thickness: 0.3,),
                    itemCount: companion.length 
                    ) : const Center(
                      child: Text("No companion added"),
                    )
                  ),
                    const Divider(thickness:0.5),
                   sizedBox(height: 10 ),
                   const  Row(children: [ Text('Expected budget',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)]), 
                   sizedBox(height: 20 ), 
                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 175,  height: 70,
                      child: TextFormField(
                        controller: _budgetController,
                        onSaved: (newValue) {
                          budget=int.parse(newValue!);
                        },
                        validator: (value) {
                    if(value==null||value.isEmpty){
                      return 'required';
                    }else if(value.length<2){
                      return 'enter Budget'; 
                    }
                    return null;
                       },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.payment,color: Colors.amber,),
                           labelText:'Budget', 
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    
                  ],
                ),
                 
               sizedBox(height: 20),
          
               
   ElevatedButton(
   onPressed: (){
    editDetails();
   },
    child:const Text("Save Changes", style: TextStyle(color: Colors.white)),
     ),
               sizedBox(height: 20),
              ],  
            ),
          ),
        ),
      ),
        );}


      ///functions///
    
     void deleteCompanion(int index) {
  setState(() {
    companion.removeAt(index);
  });
}

   editDetails(){
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      if (widget.editMode) {
        // Update existing data
        int index = Hive.box<SheduleTripMode>('sheduleTrip').values.toList().indexOf(widget.sheduleBox);
        Hive.box<SheduleTripMode>('sheduleTrip').putAt(index, SheduleTripMode(
          destination: destination!,
          startingDate: startingDate!,
          endingDate: endingDate!,
          companion: List.from(companion),
          budget: budget!,
        ));
      } else {
        // Add new data
        Hive.box<SheduleTripMode>('sheduleTrip').add(SheduleTripMode(
          destination: destination!,
          startingDate: startingDate!, 
          endingDate: endingDate!,
          companion: List.from(companion),
          budget: budget!,
        ));
      }
        Navigator.pop(context);
        
      showSnackBar(context: context, message:'changes saved', snakBarclr: Colors.green);
      
    }
   }

   startingDatePicker() {
   showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2055),
    ).then((value) {
    setState(() {
      if(value!=null){
        startingDate = DateFormat('dd-MMM-yyyy').format(value);
      }
        
      });
  });
}



 endingDatePicker() {
  showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2055),
  ).then((value) {
    setState(() {
      if(value!=null){
        endingDate = DateFormat('dd-MMM-yyyy').format(value);
      }
        
      });
  });
}
  
  void addCompanionFromContact() async {
    bool permission = await FlutterContactPicker.requestPermission();
    if (permission) {
      if (await FlutterContactPicker.hasPermission()) {
        final contact = await FlutterContactPicker.pickPhoneContact();
        if (contact != null) {
          setState(() {
            companion.add(" ${contact.fullName ?? ''}");
          });
        }
      }
    }
  }

    

}