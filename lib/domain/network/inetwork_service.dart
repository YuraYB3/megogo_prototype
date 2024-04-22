abstract interface class INetworkService {
  Stream<List<Map<String, dynamic>>> fetchDataStream(String collectionName);
}
