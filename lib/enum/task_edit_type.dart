import 'package:todo_app_flutter/constants/constants.dart';

enum TaskEditType { add, edit }

extension TaskEditTypeTitle on TaskEditType {
  String get pageTitle {
    switch (this) {
      case TaskEditType.add:
        return addTaskPageTitle;
      case TaskEditType.edit:
        return editTaskPageTitle;
    }
  }
}

extension TaskEditTypeButtonTitle on TaskEditType {
  String get buttonTitle {
    switch (this) {
      case TaskEditType.add:
        return addButtonTitle;
      case TaskEditType.edit:
        return editButtonTitle;
    }
  }
}
