extension Get<T> on List<T> {
  T? get(int index) {
    try {
      return this[index];
    } on RangeError {
      return null;
    }
  }
}
