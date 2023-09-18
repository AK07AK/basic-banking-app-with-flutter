import 'package:flutter/material.dart';
import 'package:untitled/components/atmCard.dart';
import 'package:untitled/components/operation_card.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/constants/data/card_data.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/screens/addDetails.dart';
import 'package:untitled/screens/transfer_money.dart';

import '../components/transaction_history.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper _dbhelper = new DatabaseHelper();
  String userName = "Hello! ";
  String avatar = "H";
  DateTime currentTime = DateTime.now();
  List<String> greetingList = [
    "Good Morning",
    "Good AfterNoon",
    "Good Evening",
    "Good Night"
  ];
  String? greeting;

  late List<CardData> _list;

  int current = 0;
  List datas = ["Money Transfer", "Bank Withdraw", "Insights Tracking"];

  void getGreeting() {
    if (currentTime.hour < 12) {
      greeting = greetingList[0];
    } else if (currentTime.hour >= 12 && currentTime.hour < 18) {
      greeting = greetingList[1];
    } else if (currentTime.hour >= 18 && currentTime.hour < 20) {
      greeting = greetingList[2];
    } else if (currentTime.hour >= 20 && currentTime.hour < 24) {
      greeting = greetingList[3];
    }
  }

  // Handling indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  void initState() {
    _list = CardData.cardDataList;

    getGreeting();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mgBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: mgDefaultPadding),
          child: Icon(
            Icons.menu,
            color: mgMenuColor,
            size: 35,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: mgDefaultPadding),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade200,
              child: Text(avatar),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: mgDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(greeting!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                        fontSize: 18,
                      )),
                  Text(userName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: mgBlackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //<<<<<<<<<<< ATM Card Section >>>>>>>>>>>>>>//
            SizedBox(
              height: 199,
              child: FutureBuilder(
                initialData: [],
                future: _dbhelper.getUserDetails(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding:
                    const EdgeInsets.only(left: mgDefaultPadding, right: 6),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => {
                            userName = snapshot.data?[index].userName,
                            avatar = snapshot.data?[index].userName[0],
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TransferMoney(
                                currentBalance:
                                snapshot.data?[index].totalAmount,
                                currentCustomerId: snapshot.data?[index].id,
                                currentUserCardNumebr:
                                snapshot.data?[index].cardNumber,
                                senderName: snapshot.data?[index].userName,
                              ),
                            ),
                          );
                        },
                        child: UserATMCard(
                          cardNumber: snapshot.data?[index].cardNumber,
                          cardExpiryDate: snapshot.data?[index].cardExpiry,
                          totalAmount: snapshot.data?[index].totalAmount,
                          gradientColor: _list[index].mgPrimaryGradient, cardHolderName: 'Arun',
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            //<<<<<<<<<<<< Operation section >>>>>>>>>>>>>//
            Padding(
              padding: const EdgeInsets.only(
                  left: mgDefaultPadding,
                  bottom: 13,
                  top: 29,
                  right: mgDefaultPadding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Operation",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: map<Widget>(datas, (index, selected) {
                        return Container(
                          margin: const EdgeInsets.only(right: 3),
                          height: 9,
                          width: 9,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: current == index
                                ? mgBlueColor
                                : Colors.grey[400],
                          ),
                        );
                      }),
                    ),
                  ]),
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                padding: const EdgeInsets.only(left: mgDefaultPadding),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                      });
                    },
                    child: OperationCard(
                      operation: datas[index],
                      operationIcon: operationIcon[index],
                      isSelected: current == index,
                    ),
                  );
                },
              ),
            ),

            // <<<<<<<<< Transaction Section >>>>>>>>>>>> //
            Padding(
              padding: const EdgeInsets.only(
                  left: mgDefaultPadding,
                  bottom: 13,
                  top: 29,
                  right: mgDefaultPadding),
              child: Text(
                "Transaction Histories",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),

            FutureBuilder(
              initialData: [],
              future: _dbhelper.getTransactionDetails(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: mgDefaultPadding),
                  itemBuilder: (context, index) {
                    return TransactionHistory(
                      isTransfer: true,
                      customerName: snapshot.data![index].userName,
                      transferAmount:snapshot.data![index].transectionAmount,
                      senderName: snapshot.data![index].senderName,
                      avatar: 'm',
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: mgBlueColor,
        elevation: 15,
        child: Container(
          height: 50,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mgBlueColor,
        onPressed: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 100),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.easeInOutCubic);
                    return ScaleTransition(
                      scale: animation,
                      alignment: Alignment.bottomCenter,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return AddCardDetails();
                  }));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
