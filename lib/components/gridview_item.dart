import 'package:flutter/material.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem(
      {Key? key, this.title, this.color, this.onTap, this.selected})
      : super(key: key);

  final String? title;
  final Color? color;
  final VoidCallback? onTap;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: color,
        child: Center(
          child: Row(
            children: [
              Text(
                title.toString(),
              ),
              selected ?? false ? Icon(Icons.check) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
