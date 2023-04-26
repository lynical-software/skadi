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
