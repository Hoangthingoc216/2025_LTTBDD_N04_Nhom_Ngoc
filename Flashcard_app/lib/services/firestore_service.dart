import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard_app/models/flashcard_model.dart';

class FirestoreService {
  final FirebaseFirestore data = FirebaseFirestore.instance;

  Future<void> addFlashcardTopic(FlashcardTopic topic) async {
    await data.collection('flashcard_topics').add(topic.toMap());
  }

  Future<List<FlashcardTopic>> getFlashcardTopics() async {
    QuerySnapshot snapshot = await data.collection('flashcard_topics').get();
    return snapshot.docs
        .map(
          (doc) => FlashcardTopic.fromFirestore(
            doc.id,
            doc.data() as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
