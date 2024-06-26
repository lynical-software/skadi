import 'package:flutter/widgets.dart';
import 'package:skadi/skadi.dart';

extension SkadiListExtension<T> on List<T> {
  ///Filter list that return empty if no item found
  ///instead of throwing an exception
  List<T> filter(bool Function(T element) test) {
    List<T> filtered = [];
    for (var item in this) {
      bool passed = test(item);
      if (passed) filtered.add(item);
    }
    return filtered;
  }

  ///Add item to List if it doesn't exist
  ///Remove item if exist
  void addOrRemove(T value) {
    if (contains(value)) {
      remove(value);
    } else {
      add(value);
    }
  }

  ///Find one item in the List with the condition
  ///Return null if no item found instead of throwing an exception
  T? findOne(bool Function(T element) test) {
    for (var item in this) {
      bool passed = test(item);
      if (passed) {
        return item;
      }
    }
    return null;
  }

  ///Get element from list without throwing an error
  T? get(int index) {
    if (index >= length) {
      return null;
    }
    return this[index];
  }

  T? get beforeLast {
    if (isEmpty) return null;
    if (length == 1) return first;
    return this.get(length - 2);
  }

  ///Update list value that met the condition
  ///[updateAll] param to indicate to update all pass test value or only first occurrence
  bool update(
    bool Function(T element) test,
    T Function(T element) value, {
    bool updateAll = true,
  }) {
    bool found = false;
    for (var i = 0; i < length; i++) {
      bool passed = test(this[i]);
      if (passed) {
        found = true;
        this[i] = value(this[i]);
        if (!updateAll) {
          return found;
        }
      }
    }
    return found;
  }

  ///Convert to a List of number to `SkadiResponsive`'s value.
  ///Return cast error if isn't a List of number
  double responsive([BuildContext? context]) {
    List<num> values = map((e) => e as num).toList();
    if (isEmpty) return 0;
    return SkadiResponsive.value(
      values.first.toDouble(),
      values.get(1)?.toDouble(),
      values.get(2)?.toDouble(),
      values.get(3)?.toDouble(),
      context,
    );
  }
}

extension SkadiMapExtension<K, V> on Map<K, V> {
  ///Add item into map if value isn't null
  void addIfNotNull(K key, V value) {
    if (value != null) putIfAbsent(key, () => value);
  }

  ///Return value or null from Map
  V? getIfExist(K key) {
    if (keys.contains(key)) {
      return this[key];
    }
    return null;
  }
}
