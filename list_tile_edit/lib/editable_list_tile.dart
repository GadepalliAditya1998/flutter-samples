import 'package:flutter/material.dart';
import 'package:list_tile_edit/list_model.dart';

class EditableListTile extends StatefulWidget {
  final ListModel model;
  final Function(ListModel listModel) onChanged;
  EditableListTile({Key key, this.model, this.onChanged})
      : assert(model != null),
        super(key: key);

  @override
  _EditableListTileState createState() => _EditableListTileState();
}

class _EditableListTileState extends State<EditableListTile> {
  ListModel model;

  bool _isEditingMode;

  TextEditingController _titleEditingController, _subTitleEditingController;

  @override
  void initState() {
    super.initState();
    this.model = widget.model;
    this._isEditingMode = false;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: titleWidget,
      subtitle: subTitleWidget,
      trailing: tralingButton,
    );
  }

  Widget get titleWidget {
    if (_isEditingMode) {
      _titleEditingController = TextEditingController(text: model.title);
      return TextField(
        controller: _titleEditingController,
      );
    } else
      return Text(model.title);
  }

  Widget get subTitleWidget {
    if (_isEditingMode) {
      _subTitleEditingController = TextEditingController(text: model.subTitle);
      return TextField(
        controller: _subTitleEditingController,
      );
    } else
      return Text(model.subTitle);
  }

  Widget get tralingButton {
    if (_isEditingMode) {
      return IconButton(
        icon: Icon(Icons.check),
        onPressed: saveChange,
      );
    } else
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: _toggleMode,
      );
  }

  void _toggleMode() {
    setState(() {
      _isEditingMode = !_isEditingMode;
    });
  }

  void saveChange() {
    this.model.title = _titleEditingController.text;
    this.model.subTitle = _subTitleEditingController.text;
    _toggleMode();
    if (widget.onChanged != null) {
      widget.onChanged(this.model);
    }
  }
}
