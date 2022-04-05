
import 'package:flutter/material.dart';
import 'package:my_staff_book/data/local/db/app_db.dart';
import 'package:provider/provider.dart';

class EmployeeAddressScreen extends StatelessWidget {
  const EmployeeAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Address'),
        centerTitle: true,
      ),
      body:
      StreamBuilder<List<EmployeeAddressData>>(
        stream: Provider.of<AppDb>(context).getEmployeeAddressList(),
        builder: (context, snapshot) {
          final List<EmployeeAddressData>? addresses = snapshot.data;
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
          if (addresses != null) {

            return ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {

                  final address = addresses[index];
                  return GestureDetector(
                    onTap: ()  {
                      // Navigator.pushNamed(context, '/edit_employee',arguments: address);
                    },
                    child: Card(
                      //color: Colors.grey.shade400,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.purple,
                              style: BorderStyle.solid,
                              width: 1.2
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0)
                          )

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('id: ${address.id}'),
                            Text('street: ${address.street}',style: const TextStyle(color: Colors.black),),
                            Text('city: ${address.country}',style: const TextStyle(color: Colors.black),),
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