import '../models/LinkBlock.dart';

class MyLink {
  int? mylinkId;
  int? userId;
  int? totalViews;
  int? totalClicks;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<LinkBlock>? linkBlocks;

  MyLink({
    this.mylinkId,
    this.userId,
    this.totalViews,
    this.totalClicks,
    this.createdAt,
    this.updatedAt,
    this.linkBlocks,
  });

  factory MyLink.fromJson(Map<String, dynamic> json) {
    return MyLink(
      mylinkId: json["mylink_id"] ?? '',
      userId: json["user_id"] ?? '',
      totalViews: json["total_views"] ?? '',
      totalClicks: json["total_clicks"] ?? '',
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      linkBlocks: json["link_blocks"] != null
          ? List<LinkBlock>.from(
              json["link_blocks"].map((x) => LinkBlock.fromJson(x)))
          : [], // Menggunakan list kosong jika link_blocks null
    );
  }
}
