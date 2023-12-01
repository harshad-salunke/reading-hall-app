import 'package:flutter/material.dart';

class CollegeNameField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
 final List<String> items ;

  CollegeNameField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.items
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        readOnly: true,
        onTap: () {
          // focusNode.unfocus();
          final RenderBox textFieldRenderBox = context.findRenderObject() as RenderBox;
          final Offset textFieldOffset = textFieldRenderBox.localToGlobal(Offset.zero);
          final RelativeRect position = RelativeRect.fromLTRB(
            textFieldOffset.dx+25,
            textFieldOffset.dy + textFieldRenderBox.size.height,
            textFieldOffset.dx + textFieldRenderBox.size.width,
            textFieldOffset.dy + textFieldRenderBox.size.height + kMinInteractiveDimension,
          );

          showMenu(
            context: context,
            position: position,
            items: items.map((String item) {
              return PopupMenuItem<String>(
                value: item,
                child: Container(
                  width: textFieldRenderBox.size.width,
                    child: Column(
                      children: [Text(item,
                      textAlign: TextAlign.start,),
                        Divider(
                            color: Colors.black
                        )],
                    )),
              );
            }).toList(),
          ).then((value) {
            if (value != null) {
              controller.text=value;
            }
          });
        },
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            suffixIcon: Icon(Icons.arrow_drop_down),
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
