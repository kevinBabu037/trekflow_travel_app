import 'package:flutter/material.dart';
import 'package:travel_app/reuseable_widgets/reuseable_widgets.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
       actions:const [ Icon(Icons.abc,color: Colors.white,)],
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [ Text('About '),Icon(Icons.info,color: Colors.amber,)]),
      ),
      body: SingleChildScrollView(
             child: Padding(padding:const EdgeInsets.all(15),
               child: Column(
                children: [
                       const Text(aboutText,style: TextStyle(fontSize:16 ),),
                       const  Row (mainAxisAlignment: MainAxisAlignment.center, children: [Text('V e r s i o n',style:TextStyle(fontSize: 16,color: Colors.grey),)],),
                       const  Row (mainAxisAlignment: MainAxisAlignment.center, children: [Text('1.0',style:TextStyle(fontSize: 14 ,color: Colors.grey),)],),
                 sizedBox(height: 10)
                ], 
               ),
             ),
      ),
    );
  }
}