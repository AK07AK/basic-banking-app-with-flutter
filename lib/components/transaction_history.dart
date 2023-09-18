import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  final String? customerName,avatar;
  final String? senderName;
  final bool? isTransfer;
  final double? transferAmount;
  const TransactionHistory({super.key, required this.customerName, required this.avatar, required this.senderName, required this.isTransfer, required this.transferAmount});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
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
        children: [
          Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(widget.avatar!),
            ),
          ),

          const SizedBox(width: 10,),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.senderName!,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15
                ),
              ),
              Text(
                widget.senderName!,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.grey,
                  fontSize: 12
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                widget.isTransfer!
                    ? '+ ₹ ${widget.transferAmount}'
                    : '- ₹ ${widget.transferAmount}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: widget.isTransfer! ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],


      ),


    );
  }
}
