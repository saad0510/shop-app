import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/shared/user/data/datasources/user_local_data_source.dart';
import 'package:shopping_app/shared/user/data/models/user_data_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPrefs extends Mock implements SharedPreferences {}

void main() {
  late UserDataModel userDataModel;
  late UserLocalDataSourceImp datasource;
  late MockSharedPrefs mockSharedPrefs;
  const cache_fixture = "user_data_cache.json";
  const cache_key = "USER_DATA_KEY";

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
    mockSharedPrefs = MockSharedPrefs();
    datasource = UserLocalDataSourceImp(sharedPrefs: mockSharedPrefs);
  });

  group("getLastUserData", () {
    test(
      'should return UserDataModel from SharedPrefs when present in cache',
      () async {
        // arrange
        when(() => mockSharedPrefs.getString(any()))
            .thenAnswer((_) => readFixture(cache_fixture));
        // act
        final result = await datasource.getLastUserData();
        // assert
        expect(result, userDataModel);
        verify(() => mockSharedPrefs.getString(cache_key)).called(1);
        verifyNoMoreInteractions(mockSharedPrefs);
      },
    );
    test(
      'should throw a CacheException when absent in cache',
      () async {
        // arrange
        when(() => mockSharedPrefs.getString(any())).thenAnswer((_) => null);
        // act
        final call = datasource.getLastUserData;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        verify(() => mockSharedPrefs.getString(cache_key)).called(1);
        verifyNoMoreInteractions(mockSharedPrefs);
      },
    );
  });

  group("cacheUserData", () {
    test(
      'should cache the data using SharedPrefs ',
      () async {
        // arrange
        when(() => mockSharedPrefs.setString(any(), any()))
            .thenAnswer((_) async => true);
        // act
        await datasource.cacheUserData(userDataModel);
        // assert
        final jsonStr = jsonEncode(userDataModel.toMap());
        verify(() => mockSharedPrefs.setString(cache_key, jsonStr)).called(1);
        verifyNoMoreInteractions(mockSharedPrefs);
      },
    );
    test(
      'should throw CacheException on failure',
      () async {
        // arrange
        when(() => mockSharedPrefs.setString(any(), any()))
            .thenAnswer((_) async => false);
        // act and assert
        expect(
          () => datasource.cacheUserData(userDataModel),
          throwsA(const TypeMatcher<CacheException>()),
        );
        // assert
        final jsonStr = jsonEncode(userDataModel.toMap());
        verify(() => mockSharedPrefs.setString(cache_key, jsonStr)).called(1);
        verifyNoMoreInteractions(mockSharedPrefs);
      },
    );
  });
}
