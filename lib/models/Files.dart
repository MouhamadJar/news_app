class Files {
  Files({
    required this.src,
    required this.type,
  });

  late String src;
  late String type;

  Files.fromJson(dynamic json) {
    src = json['src'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['src'] = src;
    map['type'] = type;
    return map;
  }
}
