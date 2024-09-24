class ShowModel {
  final String? name;
  final String? summary;
  final String? image;
  final double? rating;
  final List<String>? genres;
  final int? runtime;
  final String? language;

  ShowModel({
    this.name,
    this.summary,
    this.image,
    this.rating,
    this.genres,
    this.runtime,
    this.language,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
      name: json['show']['name'] as String?,
      summary: json['show']['summary'] as String?,
      image:
          json['show']['image'] != null ? json['show']['image']['original'] as String? : null,
      rating: (json['show']['rating']?['average'] as num?)?.toDouble(),
      genres: (json['show']['genres'] as List<dynamic>?)
          ?.map((genre) => genre as String)
          .toList(),
      runtime: json['show']['runtime'] as int?,
      language: json['show']['language'] as String?,
    );
  }
}
