import 'package:my_staff_book/noifier/employee_address_change_notifier.dart';
import 'package:my_staff_book/noifier/employee_change_notifier.dart';
import 'package:my_staff_book/screen/employee_address_screen.dart';
import 'package:my_staff_book/screen/employee_future.dart';
import 'package:my_staff_book/screen/employee_notifier_future.dart';
import 'package:my_staff_book/screen/employee_notifier_stream.dart';
import 'package:my_staff_book/screen/employee_stream.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  //late AppDb _db;
  final pages = const [
    // EmployeeNotifierFutureScreen(),
    EmployeeStreamScreen(),
    EmployeeAddressScreen()
    //EmployeeStreamScreen()
  ];

  @override
  void initState() {
    super.initState();

    //_db = AppDb();
  }

  @override
  void dispose() {
    //_db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/add_employee');
              break;
            case 1:
              Navigator.pushNamed(context, '/add_address');
              break;
          }
        },
        icon: const Icon(Icons.add),
        label:
            index == 0 ? const Text('Add Employee') : const Text('Add Address'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            if (value == 1) {
              context.read<EmployeeChangeNotifier>().getEmployeeStream();
            }
            if (value == 2) {
              context
                  .read<EmployeeAddressChangeNotifier>()
                  .getAllEmployeeAddress();
            }
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.blueGrey.shade300,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white30,
          showSelectedLabels: false,
          showUnselectedLabels: true,
          items: const [
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.list),
            //   activeIcon: Icon(Icons.list_outlined),
            //   label: 'Employee Future'
            // ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                activeIcon: Icon(Icons.list_outlined),
                label: 'Employee Stream'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_city),
                activeIcon: Icon(Icons.location_city_outlined),
                label: 'Address')
          ]),
    );
  }
}
