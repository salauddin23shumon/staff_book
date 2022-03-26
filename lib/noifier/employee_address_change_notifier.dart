
import 'package:my_staff_book/data/local/db/app_db.dart';
import 'package:flutter/material.dart';

class EmployeeAddressChangeNotifier extends ChangeNotifier {
  AppDb? _appDb;

  void initAppDb(AppDb appDb) {
    _appDb = appDb;
  }

  List<EmployeeAddressData> _employeeList = [];
  List<EmployeeAddressData> get employeeList => _employeeList;
  List<EmployeeAddressData> _allEmployeeList = [];
  List<EmployeeAddressData> get allEmployeeList => _allEmployeeList;

  bool _isAdded = false;
  bool get  isAdded => _isAdded;
  String _error = '';
  String get error => _error;


  //insert employee address
  void insertAddress(EmployeeAddressCompanion entity) {
    _appDb?.insertAddress(entity)
    .then((value) {
      _isAdded = value >= 1 ? true : false;
      notifyListeners();
    })
    .onError((error, stackTrace) {
      _error = error.toString();
      notifyListeners();
    });
  }

  //get the emp address by emp id
 void getEmployeeAddress(int id) {
   
    _appDb?.getEmployeeAddress(id)
      .listen((event) {
       _employeeList = event;
      }); 
   
    notifyListeners();
  }

  void getAllEmployeeAddress() {

    _appDb?.getEmployeeAddressList()
      .listen((event) {
        _allEmployeeList = event;
      });

    notifyListeners();
  }

  void setIsAdded(bool value) {
    _isAdded = value;
  }

  void setError() {
    _error = '';
  }
}
