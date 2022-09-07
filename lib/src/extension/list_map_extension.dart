extension SkadiListExtension<T> on List<T> {
  ///Filter list that return empty if no item found
  ///instead of throwing an exception
  List<T> filter(bool Function(T) test) {
    List<T> filtered = [];
    for (var item in this) {
      bool passed = test(item);
      if (passed) filtered.add(item);
    }
    return filtered;
  }

  ///Find one item in the List with the condition
  ///Return null if no item found instead of throwing an exception
  T? findOne(bool Function(T) test) {
    for (var item in this) {
      bool passed = test(item);
      if (passed) {
        return item;
      }
    }
    return null;
  }

  bool update(
    bool Function(T) test,
    T Function() value, {
    bool updateAll = true,
  }) {
    bool found = false;
    for (var i = 0; i < length; i++) {
      bool passed = test(this[i]);
      if (passed) {
        found = true;
        this[i] = value();
        if (!updateAll) {
          return found;
        }
      }
    }
    return found;
  }
}

extension SkadiMapExtension<T, V> on Map<T, V> {
  ///Add item into map if value isn't null
  void addIfNotNull(T key, V value) {
    if (value != null) putIfAbsent(key, () => value);
  }

  ///Return value or null from Map
  V? getIfExist(T key) {
    if (keys.contains(key)) {
      return this[key];
    }
    return null;
  }
}
