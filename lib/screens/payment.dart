import 'package:flutter/material.dart';
import 'package:untitled/models/transaction_details.dart';
import 'package:untitled/models/user_data.dart';
import 'package:untitled/screens/home_screen.dart';

import '../components/custom_dialouge.dart';
import '../constants/constants.dart';
import '../database/database_helper.dart';

class Payment extends StatefulWidget {
  final String customerAvatar,
      senderName,
      customerName,
      customerAccountNumber,
      currentUserCardNumber;
  final int transferTouserId, currentCustomerId;
  final double currentUserBalance, tranferTouserCurrentBalance;

  Payment({
    required this.customerAvatar,
    required this.customerName,
    required this.senderName,
    required this.customerAccountNumber,
    required this.currentUserCardNumber,
    required this.currentCustomerId,
    required this.transferTouserId,
    required this.currentUserBalance,
    required this.tranferTouserCurrentBalance,
  });

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late double transferAmount;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mgBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text(widget.customerAvatar),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.customerName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Text(widget.customerAccountNumber,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600])),
              ],
            ),
          ),
          const SizedBox(height: 100),
          Column(
            children: [
              Form(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: mgDefaultPadding),
                child: TextFormField(
                  onChanged: (value) {
                    transferAmount = double.parse(value);
                  },
                  validator: (check) => "please enter amount",
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Amount",
                    prefixText: "₹ ",
                    hintStyle: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              )),
            ],
          ),
          const Spacer(),
          Flexible(
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: mgDefaultPadding * 1.5,
                    vertical: mgDefaultPadding * 5 / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Card No: ${widget.currentUserCardNumber}",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                )),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Check Balance",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: mgBlueColor,
                            ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (transferAmount == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    title: "Amount not added",
                                    description:
                                        "Please make sure that you added amount in the field",
                                    buttonText: "Cancel",
                                    addIcon: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  );
                                });
                          } else if (transferAmount >
                              widget.currentUserBalance) {
                            if (context.mounted) {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Insufficient balance"),
                                      content: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(context);
                                        },
                                        child: const Text("Failure"),
                                      ),
                                    );
                                  });
                            }
                          } else {
                            double currentUserRemainingBalance =
                                widget.currentUserBalance - transferAmount;

                            await _dbHelper.updateTotalAmount(
                                widget.currentCustomerId,
                                currentUserRemainingBalance);

                            double transferToCurrentBalance =
                                widget.tranferTouserCurrentBalance +
                                    transferAmount;

                            await _dbHelper.updateTotalAmount(
                                widget.transferTouserId,
                                transferToCurrentBalance);

                            TransactionDetails _transectionDetails =
                                TransactionDetails(
                              userName: widget.customerName,
                              senderName: widget.senderName,
                              id: widget.currentCustomerId,
                              amount: transferAmount,
                            );

                            await _dbHelper.insertTransectionHistroy(_transectionDetails);

                            if (context.mounted) {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Success"),
                                      content: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (_)=>HomePage())
                                          );
                                        },
                                        child: const Text("Thanks for using our service"),
                                      ),
                                    );
                                  });
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Transfer Now",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
