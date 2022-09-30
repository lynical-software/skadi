catchNothing(Function() fn) {
  try {
    return fn();
  } catch (e) {
    //Do nothing
  }
}
