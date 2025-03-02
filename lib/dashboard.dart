import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(18, 50, 18, 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedDate,
            style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Welcome Fideligo",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              fontSize: 24,
            ),
            maxLines: 1,
          ),
          Text("Have a nice day !",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
              )),
          SizedBox(height: 30),
          Text(
            'Today',
            style: TextStyle(
                fontSize: 18,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Tomorrow',
            style: TextStyle(
                fontSize: 18,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Upcoming',
            style: TextStyle(
                fontSize: 18,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ));
  }
}
