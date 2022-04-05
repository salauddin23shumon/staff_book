import 'package:my_staff_book/data/local/db/app_db.dart';
import 'package:my_staff_book/data/local/model/employee_data.dart';
import 'package:my_staff_book/noifier/employee_address_change_notifier.dart';
import 'package:my_staff_book/noifier/employee_change_notifier.dart';
import 'package:my_staff_book/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';

import '../widget/toast_uitlity.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({
    Key? key,
  }) : super(key: key);

  // final int id;

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  late EmployeeAddressChangeNotifier _addressChangeNotifier;
  late EmployeeChangeNotifier _employeeNotifier;
  late List<EmployeeData> _datalist;
  late EmployeeData currentEmp;

  @override
  void initState() {
    super.initState();
    _addressChangeNotifier = context.read<EmployeeAddressChangeNotifier>();
    _employeeNotifier = context.read<EmployeeChangeNotifier>();
    _addressChangeNotifier.addListener(addressListener);
    _datalist = _employeeNotifier.employeeListStream;
  }

  @override
  void dispose() {
    _countryController.dispose();
    _streetController.dispose();
    // _addressChangeNotifier.dispose();
    _addressChangeNotifier.removeListener(addressListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                addAddress();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<EmployeeData>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          // borderRadius:
                        ),
                        filled: true,
                        isDense: true,
                        hintStyle: TextStyle(fontSize: 15),
                        hintText: "Select Employee",
                        helperText: '',
                        errorStyle: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      onChanged: (EmployeeData? data) {
                        currentEmp = data!;
                      },
                      validator: (value) =>
                          value == null ? 'field required' : null,
                      items: _datalist.map((EmployeeData user) {
                        return DropdownMenuItem<EmployeeData>(
                          value: user,
                          child: Text(
                            user.firstName,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10.0,),
                    CustomTextFormField(
                      controller: _streetController,
                      txtLable: 'Street',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTextFormField(
                      controller: _countryController,
                      txtLable: 'City',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void addAddress() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final entity = EmployeeAddressCompanion(
          employee: drift.Value(currentEmp.id),
          street: drift.Value(_streetController.text),
          country: drift.Value(_countryController.text));

      context.read<EmployeeAddressChangeNotifier>().insertAddress(entity);
    }
  }

  void addressListener() {
    if (_addressChangeNotifier.isAdded) {
      // ScaffoldMessenger.of(context).showMaterialBanner(
      //   MaterialBanner(
      //     backgroundColor: Colors.pink,
      //     content: const Text('New address is added',
      //         style: TextStyle(color: Colors.white)),
      //     actions: [
      //       TextButton(
      //           onPressed: () =>
      //               ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
      //           child: const Text(
      //             'Close',
      //             style: TextStyle(color: Colors.white),
      //           ))
      //     ],
      //   ),
      // );

      context.read<EmployeeAddressChangeNotifier>().setIsAdded(false);
      ToastUtility.showToast('added successfully');
      Navigator.pop(context);
    }
    if (_addressChangeNotifier.error != '') {
      // ScaffoldMessenger.of(context).showMaterialBanner(
      //   MaterialBanner(
      //     backgroundColor: Colors.pink,
      //     content: Text(_addressChangeNotifier.error,
      //         style: const TextStyle(color: Colors.white)),
      //     actions: [
      //       TextButton(
      //           onPressed: () =>
      //               ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
      //           child: const Text(
      //             'Close',
      //             style: TextStyle(color: Colors.white),
      //           ))
      //     ],
      //   ),
      // );

      context.read<EmployeeAddressChangeNotifier>().setError();
      ToastUtility.showToast(_addressChangeNotifier.error);
      Navigator.pop(context);
    }
  }
}
