import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/core/errors/failure.dart';
import 'package:shopping_app/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:shopping_app/shared/user/data/models/user_data_model.dart';
import 'package:shopping_app/shared/user/data/repositories/user_repository_imp.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

void main() {
  late UserRepositoryImp repo;
  late MockUserRemoteDataSource mockUserRemoteDataSrc;

  setUp(() {
    mockUserRemoteDataSrc = MockUserRemoteDataSource();
    repo = UserRepositoryImp(remoteDataSource: mockUserRemoteDataSrc);
  });

  group("getUser:", () {
    late String uid;
    late UserDataModel userDataModel;

    setUp(() {
      uid = "1";
      userDataModel = const UserDataModel(
        uid: "1",
        email: "email",
        password: "password",
        firstName: "firstName",
        lastName: "lastName",
        phone: "phone",
        address: "address",
      );
    });

    test(
      'should retrieve user from remote database on success',
      () async {
        // arrange
        when(() => mockUserRemoteDataSrc.getUser(any()))
            .thenAnswer((_) async => userDataModel);
        // act
        final result = await repo.getUser(uid);
        // assert +ve
        expect(result, Success(userDataModel));
        verify(() => mockUserRemoteDataSrc.getUser(uid)).called(1);
        // assert -ve
        verifyNoMoreInteractions(mockUserRemoteDataSrc);
      },
    );
    test(
      'should throw DatabaseFailure on failure',
      () async {
        // arrange
        when(() => mockUserRemoteDataSrc.getUser(any()))
            .thenThrow(const DatabaseException());
        // act
        final result = await repo.getUser(uid);
        // assert +ve
        expect(result, const Error(DatabaseFailure()));
        verify(() => mockUserRemoteDataSrc.getUser(uid)).called(1);
        // assert -ve
        verifyNoMoreInteractions(mockUserRemoteDataSrc);
      },
    );
  });

  group("saveUser:", () {
    late UserDataModel userDataModel;

    setUp(() {
      userDataModel = const UserDataModel(
        uid: "1",
        email: "email",
        password: "password",
        firstName: "firstName",
        lastName: "lastName",
        phone: "phone",
        address: "address",
      );
      registerFallbackValue(userDataModel);
    });

    test(
      'should save a new user to remote database on success',
      () async {
        // arrange
        when(() => mockUserRemoteDataSrc.saveUser(any()))
            .thenAnswer((_) async {});
        // act
        await repo.saveUser(userDataModel);
        // assert +ve
        verify(() => mockUserRemoteDataSrc.saveUser(userDataModel)).called(1);
        // assert -ve
        verifyNoMoreInteractions(mockUserRemoteDataSrc);
      },
    );
    test(
      'should throw DatabaseFailure on failure',
      () async {
        // arrang
        when(() => mockUserRemoteDataSrc.saveUser(any()))
            .thenThrow(const DatabaseException());
        // act
        final result = await repo.saveUser(userDataModel);
        // assert +ve
        expect(result, const Error(DatabaseFailure()));
        verify(() => mockUserRemoteDataSrc.saveUser(userDataModel)).called(1);
        // assert -ve
        verifyNoMoreInteractions(mockUserRemoteDataSrc);
      },
    );
  });
}
