import 'package:code_note/core/models/hive/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';

class CodeHightlightViewer extends StatefulWidget {
  const CodeHightlightViewer({
    super.key,
    required this.note,
  });

  final NoteModel note;

  @override
  State<CodeHightlightViewer> createState() => _CodeHightlightViewerState();
}

class _CodeHightlightViewerState extends State<CodeHightlightViewer> {

  bool isCopied = false;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return Stack(
      children: [
        // code view
        SizedBox(
          width: size.width,
          child: Directionality(
            textDirection: NoteType.values[widget.note.type] == NoteType.note
              ? .rtl
              : .ltr,
            child: ClipRRect(
              borderRadius: .circular(15),
              child: HighlightView(
                widget.note.codeContent,
                language: widget.note.language.name,
                theme: atomOneDarkTheme,
                padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
    
    
        // copy icon
        Positioned(
          top: 15,
          right: NoteType.values[widget.note.type] == NoteType.note
            ? null
            : 15,
          left: NoteType.values[widget.note.type] == NoteType.note
            ? 15
            : null,
          child: GestureDetector(
            onTap: () async {
              setState(() {
                isCopied = true;
              });

              await Clipboard.setData(ClipboardData(text: widget.note.codeContent));

              await Future.delayed(Duration(seconds: 1));

              setState(() {
                isCopied = false;
              });
            },
            child: Icon(
              isCopied ? Icons.check : Icons.copy,
              color: Colors.white
            ),
          ),
        ),
      ],
    );
  }
}