import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addNewTodoTextControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);