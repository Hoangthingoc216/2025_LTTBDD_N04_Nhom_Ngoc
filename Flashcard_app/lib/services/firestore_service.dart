import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard_app/models/flashcard_model.dart';

class FirestoreService {
  final FirebaseFirestore data = FirebaseFirestore.instance;

  Future<void> addFlashcardTopic(FlashcardTopic topic) async {
    await data.collection('flashcard_topics').add(topic.toMap());
  }

  Stream<List<FlashcardTopic>> getFlashcardTopics() {
    return data.collection('flashcard_topics').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FlashcardTopic.fromFirestore(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }
}
