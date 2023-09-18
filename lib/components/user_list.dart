import 'package:flutter/material.dart';

class CustomerList extends StatefulWidget {
  final String customerName;
  final String avatar;
  String? transactionDate;
  final double currentBalance;
  CustomerList({
    required this.customerName,
    required this.currentBalance,
    required this.avatar,
  });
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.only(left: 24, top: 12, bottom: 17, right: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(8, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(),
                child: CircleAvatar(
                  backgroundColor: Colors.blue.shade200,
                  child: Text(widget.avatar),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.customerName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                ' ₹ ${widget.currentBalance}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.green, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}