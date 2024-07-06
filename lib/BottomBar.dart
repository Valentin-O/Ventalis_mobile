
import 'package:flutter/material.dart';
import 'package:ventalis_1/connection.dart';
import 'acceuilPage.dart';
import 'contact_form.dart';
class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<BottomBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (variableInt){
        setState(() {
          index = variableInt;
        });
        if(index==0 ){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>const ConectionView()));
        }
        if(index==1 ){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> ContactForm()));
        }

      },
      currentIndex: index,
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Mes commandes',
      ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_rounded),
          label: 'Nous contacter',
        ),

      ],
      selectedItemColor: const Color.fromARGB(255, 80, 80, 80),
      unselectedItemColor: const Color.fromARGB(255, 211, 211, 211),
    );
  }
}
