import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/shared/user/data/models/user_data_model.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late UserDataModel userDataModel;
  late Map<String, dynamic> userMap;

  setUp(() {
    userDataModel = const UserDataModel(
      uid: "asd232heuqwns",
      email: "acc1@fin.com",
      password: "test123",
      firstName: "Saad",
      lastName: "Bin Khalid",
      phone: "+923133094567",
      address: "Street 31, House 2, Area 2B, Landhi 3, Karachi",
    );
    userMap = {
      "uid": "asd232heuqwns",
      "email": "acc1@fin.com",
      "password": "test123",
      "firstName": "Saad",
      "lastName": "Bin Khalid",
      "phone": "+923133094567",
      "address": "Street 31, House 2, Area 2B, Landhi 3, Karachi",
    };
  });

  test(
    'should be a subclass of UserData',
    () async {
      // assert
      expect(userDataModel, isA<UserData>());
    },
  );
  test(
    'should correctly transform from map to UserDataModel',
    () async {
      // arrange
      String json = readFixture("user_data_model.json");
      Map<String, dynamic> map = jsonDecode(json);
      // act
      UserData user = UserDataModel.fromMap(map);
      // assert
      expect(user, userDataModel);
    },
  );
  test(
    'should correctly transform to map',
    () async {
      // act
      final map = userDataModel.toMap();
      // assert
      expect(map, userMap);
    },
  );
}
