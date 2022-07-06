class Convertion {
  ChangeStringToInt(data) {
    var myInt = int.parse(data);
    assert(myInt is int);
    return myInt;
  }

  ChangeListToInt(List data) {
    var myInt = int.parse(data[0]);
    assert(myInt is int);
  }
}
