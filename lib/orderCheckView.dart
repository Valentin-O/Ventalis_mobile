import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'OrderDetailsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'myAppBar.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  List<dynamic> orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';

    final String ordersUrl = 'http://127.0.0.1:8000/api/order_check';
    print(token);
    try {
      final http.Response ordersResponse = await http.get(
        Uri.parse(ordersUrl),
        headers: <String, String>{
          'authorisation': 'bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (ordersResponse.statusCode == 200) {
        setState(() {
          orders = jsonDecode(ordersResponse.body);
        });
        print(ordersResponse.body);
      } else {
        print('Failed to fetch user orders');
      }
    } catch (e) {
      print('Error fetching user orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        color: Color.fromARGB(255, 193, 214, 231),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mes Commandes',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: orders.isNotEmpty
                  ? ListView.separated(
                itemCount: orders.length,
                separatorBuilder: (context, index) => Divider(
                  color: Color.fromARGB(255, 193, 214, 231),
                  thickness: 1.0,
                ),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final totalPrice = order['orderDetails']
                      .map((detail) => detail['price'] * detail['quantity'])
                      .reduce((value, element) => value + element);
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text('Order #${order['id']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status: ${order['state']}'),
                          Text('Prix Total: $totalPrice €'),
                        ],
                      ),
                      onTap: () {
                        // Naviguer vers les détails de la commande
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrderDetailsPage(order: order, totalPrice: totalPrice)),
                        );
                      },
                    ),
                  );
                },
              )
                  : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
