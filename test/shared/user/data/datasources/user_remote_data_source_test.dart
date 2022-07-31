import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:shopping_app/shared/user/data/models/user_data_model.dart';

class MockCollectionRef extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentRef extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late MockCollectionRef mockCollectionRef;
  late MockDocumentRef mockDocRef;
  late MockDocumentSnapshot mockDocSnapshot;
  late MockFirestore mockFirestore;
  late UserRemoteDataSourceImp dataSource;

  const users_collection = "/users";
  late String uid;
  late UserDataModel userDataModel;
  late Map<String, dynamic> userMap;

  setUp(() {
    mockCollectionRef = MockCollectionRef();
    mockDocRef = MockDocumentRef();
    mockDocSnapshot = MockDocumentSnapshot();
    mockFirestore = MockFirestore();
    dataSource = UserRemoteDataSourceImp(firestore: mockFirestore);

    uid = "asd232heuqwns";
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

    when(() => mockFirestore.collection(any())).thenReturn(mockCollectionRef);
    when(() => mockCollectionRef.doc(any())).thenReturn(mockDocRef);
    when(() => mockCollectionRef.add(any()))
        .thenAnswer((_) async => mockDocRef);
    when(() => mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);

    registerFallbackValue(userDataModel);
  });

  group("getUser:", () {
    test(
      'should fetch and return user given user from database on success',
      () async {
        // arrange
        when(() => mockDocSnapshot.data()).thenReturn(userMap);
        // act
        final result = await dataSource.getUser(uid);
        // assert
        expect(result, userDataModel);
        verify(() => mockFirestore.collection(users_collection)).called(1);
        verify(() => mockCollectionRef.doc(uid)).called(1);
        verify(() => mockDocRef.get()).called(1);
        verify(() => mockDocSnapshot.data()).called(1);
        verifyNoMoreInteractions(mockFirestore);
      },
    );
    test(
      'should throw DatabaseException if document does not exits',
      () async {
        // arrange
        when(() => mockDocSnapshot.data()).thenAnswer((_) => null);
        // act & assert
        expect(
          () => dataSource.getUser(uid),
          throwsA(const TypeMatcher<DatabaseException>()),
        );
        verify(() => mockFirestore.collection(users_collection)).called(1);
        verify(() => mockCollectionRef.doc(uid)).called(1);
        verify(() => mockDocRef.get()).called(1);
        // verify(() => mockDocSnapshot.data()).called(1);
        verifyNoMoreInteractions(mockFirestore);
      },
    );
  });

  group("saveUser:", () {
    test(
      'should save the user on remote database on success',
      () async {
        // act
        await dataSource.saveUser(userDataModel);
        // assert
        verify(() => mockFirestore.collection(users_collection)).called(1);
        verify(() => mockCollectionRef.add(userMap)).called(1);
        verifyNoMoreInteractions(mockFirestore);
      },
    );
  });
}
