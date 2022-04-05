import 'dart:async';

import 'package:my_staff_book/data/local/db/app_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/local/model/employee_data.dart';

class EmployeeStreamScreen extends StatefulWidget {
  const EmployeeStreamScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeStreamScreen> createState() => _EmployeeStreamScreenState();
}

class _EmployeeStreamScreenState extends State<EmployeeStreamScreen> {
  // ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Info'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<EmployeeData>>(
        stream: Provider.of<AppDb>(context).getEmployeeStream(),
        builder: (context, snapshot) {
          final List<EmployeeData>? employees = snapshot.data;

          if (snapshot.hasData) {
            debugPrint('Got new data');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (employees != null) {
            return ListView.builder(
                itemCount: employees.length,
                // reverse: true,
                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/edit_employee',
                          arguments: employee);
                    },
                    child: Card(
                      //color: Colors.grey.shade400,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 1.2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('id: ${employee.id}'),
                            Text(
                              'username: ${employee.userName}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(
                              'first name: ${employee.firstName}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(
                              'last name: ${employee.lastName}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(
                              'DOB: ${employee.dateOfBirth}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }

          return const Text('No data found');
        },
      ),
    );
  }
}
