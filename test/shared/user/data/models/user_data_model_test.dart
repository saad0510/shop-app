import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/shared/user/data/models/user_data_model.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const user = UserDataModel(
    uid: "asd232heuqwns",
    email: "acc1@fin.com",
    password: "test123",
    firstName: "Saad",
    lastName: "Bin Khalid",
    phone: "+923133094567",
    address: "Street 31, House 2, Area 2B, Landhi 3, Karachi",
  );
  const userMap = {
    "uid": "asd232heuqwns",
    "email": "acc1@fin.com",
    "password": "test123",
    "firstName": "Saad",
    "lastName": "Bin Khalid",
    "phone": "+923133094567",
    "address": "Street 31, House 2, Area 2B, Landhi 3, Karachi",
  };
  const fixture_name = "user_data_model.json";

  test(
    'should be a subclass of UserData',
    () async {
      expect(user, isA<UserData>());
    },
  );
  test(
    'should correctly transform from map to UserDataModel',
    () async {
      // arrange
      String json = readFixture(fixture_name);
      Map<String, dynamic> map = jsonDecode(json);
      // act
      final result = UserDataModel.fromMap(map);
      // assert
      expect(result, user);
    },
  );
  test(
    'should correctly transform to map',
    () async {
      // act & assert
      final map = user.toMap();
      expect(map, userMap);
    },
  );
}
