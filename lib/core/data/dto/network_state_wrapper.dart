import 'package:todo_app/core/data/enum/network_state.dart';

class NetworkStateWrapper<T> {
  final NetworkState state;
  final T value;
  NetworkStateWrapper({
    required this.state,
    required this.value,
  });
  NetworkStateWrapper<V> to<V>() =>
      NetworkStateWrapper(state: state, value: value as V);
}
