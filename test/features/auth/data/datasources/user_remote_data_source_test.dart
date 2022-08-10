import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:shopping_app/features/auth/data/models/user_data_model.dart';

class MockCollectionRef extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentRef extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late MockCollectionRef mockCollection;
  late MockDocumentRef mockDoc;
  late MockDocumentSnapshot mockDocSnap;
  late MockFirestore mockFirestore;
  late UserRemoteDataSourceImp dataSource;

  const users_collection = "/users";
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

  void fallbacks() {
    registerFallbackValue(user);
    when(() => mockFirestore.collection(any())).thenReturn(mockCollection);
    when(() => mockCollection.doc(any())).thenReturn(mockDoc);
    when(() => mockCollection.add(any())).thenAnswer((_) async => mockDoc);
    when(() => mockDoc.update(any())).thenAnswer((_) async {});
    when(() => mockDoc.get()).thenAnswer((_) async => mockDocSnap);
  }

  setUp(() {
    mockDoc = MockDocumentRef();
    mockCollection = MockCollectionRef();
    mockDocSnap = MockDocumentSnapshot();
    mockFirestore = MockFirestore();
    dataSource = UserRemoteDataSourceImp(firestore: mockFirestore);
    fallbacks();
  });

  void checkGetUser([bool checkError = false]) async {
    when(() => mockDocSnap.data()).thenReturn(checkError ? null : userMap);
    if (checkError) {
      expect(
        () => dataSource.getUser(user.uid),
        throwsA(const TypeMatcher<DatabaseException>()),
      );
      return;
    }
    final result = await dataSource.getUser(user.uid);
    expect(result, user);

    verify(() => mockFirestore.collection(users_collection)).called(1);
    verify(() => mockCollection.doc(user.uid)).called(1);
    verify(() => mockDoc.get()).called(1);
    verifyNoMoreInteractions(mockFirestore);
  }

  group("getUser:", () {
    test(
      'should return user given user from database on success',
      () async {
        checkGetUser();
      },
    );
    test(
      'should throw DatabaseException if document does not exits',
      () async {
        checkGetUser(true);
      },
    );
  });

  group("saveUser:", () {
    test(
      'should save the user on remote database on success',
      () async {
        // act
        await dataSource.saveUser(user);
        // assert
        verify(() => mockFirestore.collection(users_collection)).called(1);
        verify(() => mockCollection.add(userMap)).called(1);
        verifyNoMoreInteractions(mockFirestore);
      },
    );
  });
  group("updateUser:", () {
    test(
      'should update the user on remote database on success',
      () async {
        // act
        await dataSource.updateUser(user);
        // assert
        verify(() => mockFirestore.collection(users_collection)).called(1);
        verify(() => mockCollection.doc(user.uid)).called(1);
        verify(() => mockDoc.update(user.toMap())).called(1);
        verifyNoMoreInteractions(mockFirestore);
      },
    );
  });
}
