class EnumValue {
  String name;
  int value;

  EnumValue({this.name, this.value});

}

class Enums {
  List<EnumValue> enumValues;

  Enums({this.enumValues});

  List<String> enumNameList() {
    return this.enumValues.map((e) => e.name).toList();
  }

  String enumName(int value) {
    EnumValue enumValue =
        this.enumValues.firstWhere((item) => item.value == value, orElse: () {
      return new EnumValue();
    });
    return enumValue?.name ?? '';
  }
}
