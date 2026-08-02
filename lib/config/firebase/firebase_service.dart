import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../data_base/data_base_service.dart';

@LazySingleton(as: DatabaseService)
class FirebaseService implements DatabaseService {
  final FirebaseFirestore _firestore;

  FirebaseService(this._firestore);

  @override
  Future<T?> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> json, String id) fromFirestore,
  }) async {
    final snapshot = await _firestore.doc(path).get();
    if (snapshot.exists) {
      return fromFirestore(snapshot.data() ?? {}, snapshot.id);
    }
    return null;
  }

  @override
  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> json, String id) fromFirestore,
    Map<String, dynamic>? queryParams,
    int? limit,
  }) async {
    Query query = _firestore.collection(path);

    if (queryParams != null) {
      queryParams.forEach((field, value) {
        query = query.where(field, isEqualTo: value);
      });
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  @override
  Future<void> setData<T>({
    required String path,
    required T data,
    required Map<String, dynamic> Function(T value) toFirestore,
    bool merge = true,
  }) async {
    await _firestore.doc(path).set(toFirestore(data), SetOptions(merge: merge));
  }

  @override
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.doc(path).update(data);
  }

  @override
  Future<String> addData<T>({
    required String collectionPath,
    required T data,
    required Map<String, dynamic> Function(T value) toFirestore,
  }) async {
    final docRef = await _firestore
        .collection(collectionPath)
        .add(toFirestore(data));
    return docRef.id;
  }

  @override
  Future<void> deleteData(String path) async {
    await _firestore.doc(path).delete();
  }

  @override
  Stream<T?> watchDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> json, String id) fromFirestore,
  }) {
    return _firestore.doc(path).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return fromFirestore(snapshot.data() ?? {}, snapshot.id);
      }
      return null;
    });
  }

  @override
  Stream<List<T>> watchCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> json, String id) fromFirestore,
    Map<String, dynamic>? queryParams,
  }) {
    Query query = _firestore.collection(path);

    if (queryParams != null) {
      queryParams.forEach((field, value) {
        query = query.where(field, isEqualTo: value);
      });
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => fromFirestore(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList();
    });
  }
}
