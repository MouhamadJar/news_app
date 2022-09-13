class IsLike {
  IsLike({
    required this.userId,
    required this.isLike,
  });

  late String userId;
  late String isLike;

  IsLike.fromJson(dynamic json) {
    userId = json['user_id'].toString();
    isLike = json['is_like'].toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['is_like'] = isLike;
    return map;
  }
}
