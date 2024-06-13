import 'package:equatable/equatable.dart';

abstract class AbstractModel extends Equatable {
  AbstractModel copyWith();
  Map<String, dynamic> toJson();
}
