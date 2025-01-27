import 'package:flutter/material.dart';
import 'package:hotelapp/components/my_button.dart';
import 'package:hotelapp/models/hotele.dart';
import 'package:hotelapp/pages/home.dart';
import 'package:hotelapp/services/database/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {

  FirestoreService db = FirestoreService();
  @override
  void initState() {
    super.initState();

    String receipt = context.read<Restaurant>().displayCardReceipt();
    db.saveOrdertoDatabase(receipt);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Miłego pobytu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/TwuB.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            MyButton(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(),)
                );
              },
              text: 'Powrót do strony głównej',
            ),
          ],
        ),
      ),
    );
  }
}