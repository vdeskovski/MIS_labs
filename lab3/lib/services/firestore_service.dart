import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab3/models/joke.dart';

class FireStorageService {
  Future<void> createUserInFirestore(User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentReference userRef = users.doc(user.uid);
    DocumentSnapshot userSnapshot = await userRef.get();
    if (!userSnapshot.exists) {
      await userRef.set({
        'email': user.email,
      });
    }
  }

  Future<void> addJokeToFavorites(Joke joke) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference favorites = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites');
      QuerySnapshot querySnapshot =
          await favorites.where('id', isEqualTo: joke.id).get();
      if (querySnapshot.docs.isEmpty) {
        await favorites.add(joke.toMap());
      }
    }
  }

  Future<void> removeJokeFromFavorites(Joke joke) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference favorites = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites');
      QuerySnapshot querySnapshot =
          await favorites.where('id', isEqualTo: joke.id).get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }
      }
    }
  }

  Future<List<Joke>?> fetchFavoriteJokes() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        CollectionReference favorites = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('favorites');

        QuerySnapshot snapshot = await favorites.get();
        List<Joke> jokes = snapshot.docs
            .map((doc) => Joke.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
        return jokes;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
