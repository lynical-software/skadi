import 'package:flutter_test/flutter_test.dart';
import 'package:skadi/skadi.dart';

void main() {
  test("Test List and Map extension", () {
    List<int> data = [1, 2, 3, 4, 5, 6];
    Map<String, dynamic> map = {};
    var updated = data.update((i) => i % 2 == 0, (i) => 0);
    expect(data, [1, 0, 3, 0, 5, 0]);
    expect(updated, true);
    updated = data.update((i) => i == 0, (i) => i + 9);
    expect(data, [1, 9, 3, 9, 5, 9]);

    expect(3, data.findOne((p0) => p0 == 3));
    expect(null, data.findOne((p0) => p0 == 12));

    expect([9, 9, 5, 9], data.filter((p0) => p0 > 3));
    expect([], data.filter((p0) => p0 < 0));

    map.addIfNotNull("age", 3);
    expect(map.containsKey("age"), true);
    expect(map["age"] == 3, true);

    map.addIfNotNull("name", null);
    expect(map.containsKey("name"), false);
    expect(map["name"] == null, true);
  });

  test("Test Form Validator", () {
    ///Email
    var error = SkadiFormValidator.validateEmail("");
    expect(error, "Please input your email");

    error = SkadiFormValidator.validateEmail("value");
    expect(error, "Invalid email");

    error = SkadiFormValidator.validateEmail("value", field: "Email");
    expect(error, "Invalid Email");

    error = SkadiFormValidator.validateEmail("value@email.com", field: "Email");
    expect(error, null);

    ///Field
    error = SkadiFormValidator.validateField("");
    expect(error, "Please input required field");

    error = SkadiFormValidator.validateField("", field: "password");
    expect(error, "Please input your password");

    error = SkadiFormValidator.validateField("1", field: "Password", length: 6);
    expect(error, "Password must be 6 characters long");

    error = SkadiFormValidator.validateField("value", length: 6);
    expect(error, "This field required 6 characters long");

    error = SkadiFormValidator.validateField("value", field: "Email");
    expect(error, null);

    error =
        SkadiFormValidator.validateField("value", field: "Email", length: 3);
    expect(error, null);

    ///Number
    error = SkadiFormValidator.isNumber("");
    expect(error, "Please input required field");

    error = SkadiFormValidator.isNumber("", field: "age");
    expect(error, "Please input your age");

    error = SkadiFormValidator.isNumber("value");
    expect(error, "This field must be a number");

    error = SkadiFormValidator.isNumber("value", field: "age");
    expect(error, "age must be a number");

    error = SkadiFormValidator.isNumber("3333", field: "age");
    expect(error, null);
  });
}
