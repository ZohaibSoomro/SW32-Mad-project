class ProfileInfo {
  final _profileInfo = [
    'Name   : ZOHAIB HASSAN',
    'Surname: Soomro',
    'From   : Mirpur Mathelo'
  ];
  String at(int index) {
    return _profileInfo[index];
  }

  int get length {
    return _profileInfo.length;
  }
}
