class Event {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String location;
  final bool isVirtual;
  final int capacity;
  final int attendees;
  final double price;
  final bool isRsvped;
  final List<String> tags;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.location,
    required this.isVirtual,
    required this.capacity,
    required this.attendees,
    required this.price,
    required this.isRsvped,
    required this.tags,
  });

  Event copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? date,
    String? location,
    bool? isVirtual,
    int? capacity,
    int? attendees,
    double? price,
    bool? isRsvped,
    List<String>? tags,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      date: date ?? this.date,
      location: location ?? this.location,
      isVirtual: isVirtual ?? this.isVirtual,
      capacity: capacity ?? this.capacity,
      attendees: attendees ?? this.attendees,
      price: price ?? this.price,
      isRsvped: isRsvped ?? this.isRsvped,
      tags: tags ?? this.tags,
    );
  }
}
