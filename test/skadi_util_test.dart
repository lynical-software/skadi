import 'package:flutter_test/flutter_test.dart';
import 'package:skadi/skadi.dart';

void main() {
  test("Test List update", () {
    List<int> data = [1, 2, 3, 4, 5, 6];

    var updated = data.update((i) => i % 2 == 0, (i) => 0);
    print(data);
    expect(data, [1, 0, 3, 0, 5, 0]);
    expect(updated, true);
    updated = data.update((i) => i == 0, (i) => i + 9);
    expect(data, [1, 9, 3, 9, 5, 9]);
    print(data);
  });
}
