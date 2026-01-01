abstract class AllHistoryEvent {}

class AllHistoryFetch extends AllHistoryEvent {
  final int limit;
  AllHistoryFetch({this.limit = 10});
}

class AllHistoryLoadMore extends AllHistoryEvent {
  final int limit;
  AllHistoryLoadMore({this.limit = 10});
}
