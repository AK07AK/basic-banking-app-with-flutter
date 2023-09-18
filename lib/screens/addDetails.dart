import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/custom_dialouge.dart';
import 'package:untitled/components/custom_text_field.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/models/user_data.dart';
import 'package:untitled/screens/home_screen.dart';

class AddCardDetails extends StatefulWidget {
  @override
  _AddCardDetailsState createState() => _AddCardDetailsState();
}

class _AddCardDetailsState extends State<AddCardDetails> {
  String? cardHolderName;
  String? cardNumber;
  String? cardExpiry;
  double? currentBalance;

  final DatabaseHelper _dbhelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Account Details"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration:
                          const InputDecoration(hintText: 'Enter card name'),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        cardHolderName = value;
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter card number',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        cardNumber = value;
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter expiry date',
                      ),
                      onChanged: (value) {
                        cardExpiry = value;
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Amount',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        currentBalance = double.parse(value);
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (cardHolderName != null && cardNumber != null) {
                            UserData userData = UserData(
                              id:1234567897143,
                              userName: cardHolderName!,
                              cardNumber: cardNumber!,
                              cardExpiry: cardExpiry!,
                              totalAmount: currentBalance!,
                            );

                            await _dbhelper.insert(userData);
                            if(context.mounted) {
                              return showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Success"),
                                      content: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) => HomePage())
                                          );
                                        }, child: const Text('Proceed'),
                                      ),
                                    );
                                  });
                            }
                          } else {
                            print("Fail to insert");
                          }
                        },
                        child: const Text('Proceed'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
