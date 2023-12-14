import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:travel_app/model/shedule_model.dart';
import 'package:travel_app/reuseable_widgets/reuseable_widgets.dart';
import 'Shedule_changes.dart';

class EditSheduledDetails extends StatefulWidget {
  const EditSheduledDetails({super.key});

  @override 
  State<EditSheduledDetails> createState() => _EditSheduledDetailsState();
}
 
class _EditSheduledDetailsState extends State<EditSheduledDetails> {
   Box sheduleBox = Hive.box<SheduleTripMode>('sheduleTrip'); 
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        elevation: 0,
        centerTitle: true,
        title:const Text("Sheduled Details",style: TextStyle( fontSize: 25),),  
        backgroundColor: Colors.white, 
        ),
          
      body:sheduleBox.isEmpty?const SizedBox(
              child: Center( 
                child: Text("You don't added any plan",style: TextStyle(fontSize: 17),), 
              ),
            ):  Padding(padding:const EdgeInsets.only(top: 10 ),
        child: ListView.builder(
          itemBuilder: (context, index){
            final data = sheduleBox.getAt(index) as SheduleTripMode; 
            return  
             Container(
              margin:const EdgeInsets.only(left: 12,right: 12  ,top: 7,bottom: 10 ),
              padding:const EdgeInsets.only(left: 15,top: 5,bottom: 5),
               height:260 ,
               width: double.infinity,
               decoration: BoxDecoration( 
                  boxShadow:const [
                    BoxShadow(
                      color:  Color.fromARGB(147, 255, 193, 7),
                      blurRadius: 2 ,
                      spreadRadius:1
                    )
                  ] ,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),              
              ), 
              child: Column(
                children: [
                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                     const Text("Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                     SizedBox(
                      child: Row(children: [
                        IconButton(onPressed: (){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) =>SheduleChanges(sheduleBox: data,editMode: true) ,));
                        },
                        icon:const Icon(Icons.edit, size: 24,color: Colors.grey,)), 
                        IconButton(onPressed: (){
                         warnningAleartMsg(context: context, title: 'Delete', content: 'Are you sure want to delete?',
                          onYesPressed: () {
                            sheduleBox.deleteAt(index); 
                            setState(() { Navigator.pop(context);});
                          },
                          );
                        },
                     icon:const Icon(Icons.delete,color: Colors.amber,)),
                      ],),
                    )
                   ],),
                  
                   sheduledAllDatas(details: 'Location: ', data: data.destination),
                   sheduledAllDatas(details: 'Startaing Date: ', data: data.startingDate),
                   sheduledAllDatas(details: 'Ending Date: ', data: data.endingDate),
                   sheduledAllDatas(details: 'Budget:', data:" ₹${data.budget.toString()}") ,        
                   sizedBox(height: 10),
                 const Row(children: [Text("Selected Companions",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold   ),)],),
                
                 data.companion.isEmpty ?
            
                 const SizedBox(
                    height: 20, 
                    width: double.infinity,
                    child:  Center(
                    child: Text('No Companions'),
                     ),
                  ) :
            
                 Expanded(
                   child: ListView(
                      children: [
                        for (var companion in data.companion)
                          Text("$companion ",style:const TextStyle(fontSize: 18),), 
                      ],
                    ),
                 ),
              ],),
            );
        
          }, 
          itemCount: sheduleBox.length 
          
          ),
      ),
    );
  }
}


