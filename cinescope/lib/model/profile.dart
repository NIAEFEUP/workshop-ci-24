class Profile {
  final String userId, name, bio, pic;


  Profile(
    this.userId,
    this.name,
    this.bio,
    this.pic,
    );

  @override
  String toString() {
    return 'Profile{name: $name, bio: $bio, pic: $pic, userId: $userId)}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile && other.userId == userId; //only need to check id, because it's unique
  }
}
