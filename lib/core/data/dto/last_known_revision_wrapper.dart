class LastKnownRevisionWrapper<T> {
  final int lastKnownRevision;
  final T value;
  LastKnownRevisionWrapper({
    required this.lastKnownRevision,
    required this.value,
  });
}
