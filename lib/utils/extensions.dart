import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  Size get devicesize => MediaQuery.sizeOf(this);
}
