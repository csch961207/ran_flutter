import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ran_flutter_core/config/net/core_repository.dart';
import 'package:ran_flutter_core/model/application_configuration_model.dart';

class CoreViewModel with ChangeNotifier {
  ApplicationConfiguration applicationConfiguration =
      new ApplicationConfiguration();
  CoreViewModel() {
    init();
  }
  init() async {
    try {
      ApplicationConfiguration applicationConfigurationData =
          await CoreRepository.fetchApplicationConfiguration();
      this.applicationConfiguration = applicationConfigurationData;
      notifyListeners();
    } catch (e, s) {
      print(e);
    }
  }
}