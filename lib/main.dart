import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_staff_book/data/local/db/app_db.dart';
import 'package:my_staff_book/noifier/employee_address_change_notifier.dart';
import 'package:my_staff_book/noifier/employee_change_notifier.dart';
import 'package:my_staff_book/route/route_generator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: AppDb()),
        ChangeNotifierProxyProvider<AppDb,EmployeeChangeNotifier>(
          create: (context) => EmployeeChangeNotifier(), 
          update: (context, db, notifier) => notifier!..initAppDb(db)..getEmployeeFuture(),
        ),
        ChangeNotifierProxyProvider<AppDb,EmployeeAddressChangeNotifier>(
          create: (context) => EmployeeAddressChangeNotifier(), 
          update: (context,appDb,notifier) =>  notifier!..initAppDb(appDb),
          lazy: true,
        )
                
      ],
      child: const MyApp(),      
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(       
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute      
    );
  }
}

