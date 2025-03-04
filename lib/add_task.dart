import 'package:flutter/material.dart';
import 'package:simple_todolist/pre_page.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF5038BC),
        padding: EdgeInsets.fromLTRB(18, 50, 18, 50),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF5038BC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(40, 40), // Ukuran persegi
                      padding: EdgeInsets.zero, // Hapus padding default
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrePage()));
                    },
                    child: const Icon(Icons.arrow_back)),
                const Text("Add Task",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.normal,
                        color: Colors.white))
              ],
            )
          ],
        ));
  }
}
