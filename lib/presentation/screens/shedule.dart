import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/data/model/shedule_model.dart';
import 'package:travel_app/presentation/widgets/reuseable_widgets.dart';
class SheduledDetails extends StatefulWidget {
  const SheduledDetails({super.key});
 
  @override
  State<SheduledDetails> createState() => _SheduledDetailsState();
}

class _SheduledDetailsState extends State<SheduledDetails>{
  String? destination;
  String? startingDate;
  String? endingDate;
  List<String>companion=[];
  int? budget; 
  final _forKey=GlobalKey<FormState>();
 
 Box shedule= Hive.box<SheduleTripMode>('sheduleTrip');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); 
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Plan Your Trip',style: TextStyle(fontSize: 25),),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Form(
                key: _forKey,
                child: Column(  
                  
                  children: [ 
                    sizedBox(height: 20),
                    TextFormField(
                      onSaved: (newValue) {
                        destination=newValue;
                      },
                      validator: (value) {
                        if(value==null||value.isEmpty){
                          return 'required';
                        }return null;
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
              
                          return  
                          Row(children: [
                            Text(" ${index+1}.  ${companion[index]}"),
                             IconButton(onPressed: (){
                              if(companion.isNotEmpty){
                                companion.removeAt(index);
                                setState(() {});
                              }
                            },
                             icon:const Icon(Icons.delete,size: 20,color: Colors.grey,)),
                          ],);
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
                            onSaved: (newValue) {
                              budget=int.parse(newValue!);
                            },
                            validator: (value) {
                        if(value==null||value.isEmpty){
                          return 'required';
                        }return null;
                           },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.payment,color: Colors.amber,),
                               labelText: 'Budget',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        
                      ],
                    ),  
                   sizedBox(height: 20),
                   ElevatedButton(
                    onPressed: (){
                       {
                       addSheduleDAta();
                      }
                     
                    },
                   child:const Text("Add Trip Plan",style: TextStyle(color: Colors.white),)),
                   sizedBox(height: 20),
                  ], 
                ),
              ),
            ),
          ),
        ),
      ),
    );
  } 
       //////functions//////
 
     addSheduleDAta()async{
     String uniqueKey = DateTime.now().millisecondsSinceEpoch.toString();
      SharedPreferences prefs = await SharedPreferences.getInstance(); 
  String? id=prefs.getString('loggedInUserId');
        final isValid= _forKey.currentState!.validate();
        if(isValid){
          _forKey.currentState?.save();
          if(startingDate!=null && endingDate!=null ){
            
            shedule.add(
              SheduleTripMode( 
                 dataKey:uniqueKey ,
                 userId:id, 
                 destination: destination!,
                 startingDate: startingDate!, 
                 endingDate: endingDate!, 
                 companion: companion, 
                 budget: budget!
                 ));
                 showSnackBar(context: context,message: 'Data added succesfully',snakBarclr:Colors.green);
                 resetFields();
          }else{
            showSnackBar(context: context,message: 'select date',snakBarclr:Colors.red);
          }
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

bool isEndingDateValid(DateTime endingDate) {
  // Get the current date
  DateTime currentDate = DateTime.now();

  // Define the restriction for upcoming trips (e.g., 30 days from the current date)
  DateTime allowedEndDate = currentDate.add(const Duration(days: 30));

  // Check if the selected ending date is within the allowed range
  if (endingDate.isBefore(currentDate) || endingDate.isAfter(allowedEndDate)) {
    showSnackBar(
      context: context,
      message: 'Ending date must be within 30 days from the current date.',
      snakBarclr: Colors.red,
    );
    return false;
  }

  return true;
}

// Modify your endingDatePicker function to use the validation
endingDatePicker() {
  showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2055),
  ).then((value) {
    setState(() {
      if (value != null) {
        endingDate = DateFormat('dd-MMM-yyyy').format(value);

        if (!isEndingDateValid(value)) {
          endingDate = null; 
        }
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
        String fullName = contact.fullName ?? '';
        // Check if the companion with the same name already exists (case-insensitive)
        if (!companion.any((name) => name.trim().toLowerCase() == fullName.trim().toLowerCase())) {
          setState(() {
            companion.add(" $fullName");
          });
        } else {
          // Show a message or handle the case where the companion already exists
          showSnackBar( context: context, message: 'Companion $fullName already added',snakBarclr: Colors.red,);
        }
      }
    }
  }
}
    void resetFields() {
    setState(() {
      _forKey.currentState?.reset();
      destination = null;
      startingDate = null;
      endingDate = null;
      companion = [];
      budget = null;
    });
  }
}



