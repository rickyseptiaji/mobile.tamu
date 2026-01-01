abstract class HomeHistoryEvent {}


class HomeHistoryFetch extends HomeHistoryEvent {
  final int limit;

  HomeHistoryFetch({
    this.limit = 5,
  });
}

class LoadHistoryDetail extends HomeHistoryEvent {
  final String slug;

  LoadHistoryDetail({required this.slug});
}