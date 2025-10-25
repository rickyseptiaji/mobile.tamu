abstract class DetailVisitorEvent {}

class LoadDetailVisitor extends DetailVisitorEvent {
  final String id;
  LoadDetailVisitor(this.id);
}
