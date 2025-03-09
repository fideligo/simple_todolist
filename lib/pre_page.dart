import 'package:flutter/material.dart';
import 'package:simple_todolist/add_task.dart';
import 'package:simple_todolist/dashboard.dart';
import 'edit_task.dart';

class PrePage extends StatelessWidget {
  const PrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 50, 95),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Remove this after finish
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => EditTask()),
            //       );
            //     },
            //     style: ElevatedButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10)),
            //         backgroundColor: const Color(0xFF5038BC),
            //         foregroundColor: Colors.white),
            //     child: const Text('testing',
            //         style: TextStyle(
            //             fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
            //   ),
            // ),
            // Remove after finish [UNTIL HERE]
            Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/tudulis.png'),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Tudulis',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF5038BC)),
            ),
            const Text(' Turn your to-dos into done.',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: const Color(0xFF5038BC),
                    foregroundColor: Colors.white),
                child: const Text('Let’s Get Things Done',
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// YAPPING
