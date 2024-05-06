import 'package:flutter/material.dart';
import 'package:travel_app/presentation/admin_side/admin_all_data.dart';
import 'package:travel_app/presentation/admin_side/admin_data_adding.dart';

class AdminNavbar extends StatefulWidget {
 const  AdminNavbar({super.key});

  @override
  State<AdminNavbar> createState() => _AdminNavbarState();
}

class _AdminNavbarState extends State<AdminNavbar> {
   int _correntAdminNavIndex=0;

   final pagesOfAdmin= [ 
    const AdminDataAddingPage(),
   const AdminAllData()
   ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pagesOfAdmin[_correntAdminNavIndex] ,
      bottomNavigationBar:  BottomNavigationBar(
            selectedItemColor: Colors.amber,
            unselectedItemColor:const Color.fromARGB(153, 158, 158, 158) ,
            elevation: 0,
            backgroundColor:const Color.fromARGB(15, 255, 193, 7),
        type: BottomNavigationBarType.fixed,
        currentIndex: _correntAdminNavIndex, 
        onTap: (newIdex) {
          setState(() {
             _correntAdminNavIndex=newIdex;
          });
        },
        

         items:const [  
         BottomNavigationBarItem(icon:Icon(Icons.add_alert_rounded, size: 32,),label: ''),
         BottomNavigationBarItem(icon:Icon(Icons.list_alt_rounded,size: 32),label: '',) 
       
      ],),
    );
  }
}