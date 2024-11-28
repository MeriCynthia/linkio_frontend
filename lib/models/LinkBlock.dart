class LinkBlock {
  int? linkBlockId;
  int? mylinkId;
  String? linkTitle;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;

  LinkBlock({
    this.linkBlockId,
    this.mylinkId,
    this.linkTitle,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  factory LinkBlock.fromJson(Map<String, dynamic> json) {
    return LinkBlock(
      linkBlockId: json["link_block_id"],
      mylinkId: json["mylink_id"],
      linkTitle: json["link_title"],
      url: json["url"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
