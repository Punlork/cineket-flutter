// ignore_for_file: inference_failure_on_untyped_parameter, type_annotate_public_apis, unnecessary_lambdas

import 'dart:convert';

JsonDecoder decoder = const JsonDecoder();
JsonEncoder encoder = const JsonEncoder.withIndent('  ');

void getPrettyJSONString(input) {
  final object = decoder.convert(input);
  final prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((element) => print(element));
}
