class UserData {
  final String userName;
  final String cardNumber;
  final String cardExpiry;
  final double totalAmount;
  int id;
  UserData({
    required this.cardNumber,
    required this.cardExpiry,
    required this.userName,
    required this.totalAmount,
    required this.id
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'userName': userName,
      'cardNumber': cardNumber,
      'cardExpiry': cardExpiry,
      'totalAmount': totalAmount,
    };
  }
}