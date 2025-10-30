final class SeedData {
  SeedData._({
    required this.collectionName,
    required this.data,
  });

  /// The name of the collection to seed.
  final String collectionName;

  /// The list of data entries to seed into the collection.
  final List<Map<String, dynamic>> data;
}

SeedData resolveSeedData({
  required String collectionName,
  required List<Map<String, dynamic>> data,
}) => SeedData._(
  collectionName: collectionName,
  data: data,
);
