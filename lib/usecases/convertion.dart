class ConvertionUseCase {
  ChangeStringToInt(data) {
    var myInt = int.parse(data);
    assert(myInt is int);
    return myInt;
  }

  ChangeListToInt(data) {
    var myInt = int.parse(data);
    assert(myInt is int);
  }
}
