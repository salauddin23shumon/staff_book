
import 'package:my_staff_book/screen/add_address.dart';
import 'package:my_staff_book/screen/add_employee_screen.dart';
import 'package:my_staff_book/screen/edit_employee_screen.dart';
import 'package:my_staff_book/screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../data/local/model/employee_data.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/add_employee':
        return MaterialPageRoute(builder: (_) => const AddEmployeeScreen()); 
       case '/edit_employee':
        if (args is EmployeeData) {
          return MaterialPageRoute(builder: (_) =>  EditEmployeeScreen(data: args));
        }
        return _errorRoute(); 
        case '/add_address':
          return MaterialPageRoute(builder: (_) =>  AddAddress());
        return _errorRoute();          
      default:
        return _errorRoute();
    }

  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Route'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Sorry no route was found!', style: TextStyle(color: Colors.red, fontSize: 18.0)),
        ),
      );
    });
  }
}