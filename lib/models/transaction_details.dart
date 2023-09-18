class TransactionDetails{
  final int id;
   int? tansactionId;
  final String userName;
  final String senderName;
  final double amount;

  TransactionDetails({
    required this.id,
     this.tansactionId,
    required this.userName,
    required this.senderName,
    required this.amount,
});

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'transectionId': tansactionId,
      'userName': userName,
      'senderName': senderName,
      'transectionAmount': amount,
    };
  }
}
