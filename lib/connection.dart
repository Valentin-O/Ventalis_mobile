import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventalis_1/orderCheckView.dart';
import 'myAppBar.dart';

class ConectionView extends StatefulWidget {
  const ConectionView({Key? key}) : super(key: key);

  @override
  State<ConectionView> createState() => _ConectionViewState();
}

class _ConectionViewState extends State<ConectionView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final String apiUrl = 'https://www.venta.osterweb.fr/api/login_check';

    final Map<String, dynamic> data = {
      'username': usernameController.text,
      'password': passwordController.text,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control_Allow_Origin': '*',
          'Access-Control-Allow-Headers': 'Access-Control-Allow-Origin, Accept',
          'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD'
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderListPage()),
        );
        _fetchUserInfo(token);
      } else {
        print('Échec de l\'authentification');
        print(response.body);
      }
    } catch (e) {
      print('Erreur de la requête: $e');
    }
  }

  Future<void> _fetchUserInfo(String token) async {
    try {
      List<String> tokenParts = token.split('.');
      if (tokenParts.length != 3) {
        throw Exception('Invalid token format');
      }
      String decodedPayload = utf8.decode(base64Url.decode(base64.normalize(tokenParts[1])));
      Map<String, dynamic> decodedData = jsonDecode(decodedPayload);
      String username = decodedData['username'];
      print('Username: $username');
    } catch (e) {
      print('Erreur lors de la récupération des informations du jeton : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Color.fromARGB(1000, 193, 214, 231),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.8,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,235,235,235),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Log In',
                      style: TextStyle(
                        color : Color.fromARGB(255,92,149,195),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Satisfy'
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Login',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),

                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _login,
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
                      child: Text('GO',
                        style: TextStyle(
                          color : Color.fromARGB(255,92,149,195),
                          fontFamily: 'Satisfy',
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
