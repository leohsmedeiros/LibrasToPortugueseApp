class ClassifiedSigned {
  double confidence;
  int index;
  String label;

  ClassifiedSigned({this.confidence, this.index, this.label});

  String result() => label?.split(" ")?.last ?? "";

  @override
  String toString() => "{ index: $index, result: ${result()}, confidence: $confidence }";

}
