import 'package:cloud_firestore/cloud_firestore.dart';

//FIXME: remove this class when profile editing is done
class Profile {

  const Profile();

  factory Profile.fromMap(Map<String, dynamic> map){
    return const Profile();
  }

  Map<String, dynamic> toMap() => {};
}

class Comment {
  final String content;
  final DateTime creationTime;
  final Profile createdBy;

  Comment(this.content, this.creationTime, this.createdBy);

  factory Comment.fromMap(Map<String, dynamic> map){
    return Comment(map["content"], DateTime.parse(map["creationTime"]), map["createdBy"]);
  }

  Map<String,dynamic> toMap() => {
    "content" : content,
    "creationTime": creationTime.toIso8601String(),
    "createdBy": createdBy
  };

}

class Discussion {
  final String id;
  final String filmId;
  final String title;
  final String description;
  final Profile createdBy;
  final DateTime creationDate;
  final List<Comment> comments;

  Discussion(this.id, this.filmId,this.title, this.description, this.createdBy, this.creationDate,
      this.comments);

  factory Discussion.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>>snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception("Something went wrong while building ");
    }
    print(data);
    List<Comment> comments = []; 
    if(!data["comments"].isEmpty){
      comments = data["comments"]
        .map((element) => Comment.fromMap(element)).toList();
    }

    return Discussion(
      snapshot.id,
      data["filmId"],
      data["title"], 
      data["description"], 
      Profile.fromMap(data["createdBy"]), 
      data["creationDate"].toDate(), 
      comments);
  }

  Map<String, dynamic> toFirestore() => {
    "filmId": filmId,
    "title": title,
    "description": description,
    "createdBy": createdBy.toMap(),
    "creationDate": creationDate.toIso8601String(),
    "comments": comments.map((e) => e.toMap()).toList()
  };

  @override
  bool operator ==(Object other){
    if (identical(this, other)) return true;
    return other is Discussion && other.id == id;
  }

}
