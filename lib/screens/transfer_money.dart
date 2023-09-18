import 'package:flutter/material.dart';
import 'package:untitled/screens/payment.dart';

import '../components/user_list.dart';
import '../constants/constants.dart';
import '../database/database_helper.dart';

class TransferMoney extends StatefulWidget {
  final double currentBalance;
  final int currentCustomerId;
  final String currentUserCardNumebr, senderName;

  TransferMoney({
    required this.currentBalance,
    required this.currentCustomerId,
    required this.senderName,
    required this.currentUserCardNumebr,
  });
  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  final double _currentBalance = 0.0;
  final DatabaseHelper _dbHelper =  DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Money"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: mgDefaultPadding),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "Current Balance",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _currentBalance == widget.currentBalance
                          ? "₹ 0"
                          : "₹ ${widget.currentBalance}",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _currentBalance == widget.currentBalance
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: _dbHelper.getUserDetail(widget.currentCustomerId),
              builder: (context, snapshot) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: mgDefaultPadding),
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Payment(
                            customerAvatar: 'M',
                            customerName: widget.senderName,
                            senderName: widget.senderName,
                            customerAccountNumber: widget.currentUserCardNumebr,
                            currentUserCardNumber:widget.currentUserCardNumebr,
                            currentCustomerId: widget.currentCustomerId,
                            currentUserBalance: widget.currentBalance,
                            transferTouserId: widget.currentCustomerId,
                            tranferTouserCurrentBalance:
                            100000,
                          ),
                        ),
                      ),
                      child: CustomerList(
                        customerName: widget.senderName,
                        currentBalance: widget.currentBalance,
                        avatar: widget.senderName[0],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
