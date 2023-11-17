class Task {
  final String id;
  final String name;
  bool isDone;

  Task({required this.id, required this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
