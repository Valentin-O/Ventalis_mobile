import 'package:flutter/material.dart';
import 'BottomBar.dart';
import 'connection.dart';
import 'contact_form.dart';
import 'myAppBar.dart';

class AcceuilView extends StatefulWidget {
  const AcceuilView({Key? key}) : super(key: key);

  @override
  State<AcceuilView> createState() => _AcceuilViewState();
}
class _AcceuilViewState extends State<AcceuilView> {
  @override
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        color: Color.fromARGB(1000,193,214,231),
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width:screenWidth * 0.8,
                height:100,
                color:Colors.white,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text('Mes commandes'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ConectionView(),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text('Voir',
                        style: TextStyle(
                          color : Color.fromARGB(255,92,149,195),
                          fontFamily: 'Satisfy',)
                    ),
                    ),
                  ],
                ),
            ),
              Container(
                width:screenWidth * 0.8,
                height:100,
                color:Colors.white,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text('Des quéstions ?'),
                    Text('Un conseillé est à votre écoute'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ContactForm(),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text('Contact',
                        style: TextStyle(
                          color : Color.fromARGB(255,92,149,195),
                          fontFamily: 'Satisfy'
                        )
                    ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}