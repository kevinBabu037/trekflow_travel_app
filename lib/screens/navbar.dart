import 'package:flutter/material.dart';
import 'edit_sheduled_details.dart';
import 'home.dart';
import 'places_page.dart';
import 'profile_page.dart';
import 'shedule.dart';



class NavBar extends StatefulWidget {
   final String? userId;

const NavBar({super.key, this.userId});

  @override
  State<NavBar> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NavBar> {
  int _currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('userid in nav bar: ${widget.userId}');
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
     const Home(),
     PlacesList(userId: widget.userId),
     const SheduledDetails(),
     const EditSheduledDetails(),
      Profile(userid: widget.userId),
    ];

    return Scaffold(
      body: pages[_currentSelectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        unselectedItemColor: const Color.fromARGB(153, 158, 158, 158),
        elevation: 0,
        backgroundColor: const Color.fromARGB(15, 255, 193, 7),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            _currentSelectedIndex = newIndex;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on_rounded, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.upcoming_rounded, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.view_list_rounded, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded, size: 32), label: ''),
        ],
      ),
    );
  }
}












