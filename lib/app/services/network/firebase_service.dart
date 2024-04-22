import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/network/inetwork_service.dart';

class FirebaseService implements INetworkService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<List<Map<String, dynamic>>> fetchDataStream(String collectionName) =>
      _firebaseFirestore
          .collection(collectionName)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}
