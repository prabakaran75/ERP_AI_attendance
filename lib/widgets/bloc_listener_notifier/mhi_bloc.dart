import 'package:flutter/material.dart';

class MHIBloc with ChangeNotifier {

  bool sslType = false;
  String domainssl = "http://";
  String domain = "";
  String port = "";
  String _role = "0";

  // String Status = "";

  bool get stateManagementsslType => sslType;

  String get stateManagementdomainssl => domainssl;

  set stateManagementsslType(bool _sslType) {
    sslType = !_sslType;
    if (sslType == false) {
      domainssl = "http://";
    } else {
      domainssl = "https://";
    }
    print(_sslType);
    notifyListeners();
  }

  String get stateManagementdomain => domain;
  set stateManagementdomain(String _domain) {
    domain = _domain;
    print(domain);
    notifyListeners();
  }

  String get stateManagementport => port;
  set stateManagementport(String _port) {
    port = _port;
    print(port);
    notifyListeners();
  }


  String get getRole => _role;
  set setRole(String role) {
    _role = role;
    notifyListeners();
  }
  // String get getStatus => Status;
  // void setStatus(String name) {
  //   Status = name;
  //   print(Status);
  //   notifyListeners();
  // }

 }


class ProgressManager extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void showProgress() {
    _isLoading = true;
    notifyListeners();
  }

  void hideProgress() {
    _isLoading = false;
    notifyListeners();
  }
}

class ConnectivityBloc {
  String status = "unknown";

  void setStatus(String newStatus) {
    status = newStatus;
    // Do any other logic you need with the new status
  }
}

