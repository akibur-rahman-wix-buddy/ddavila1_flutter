// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TextEditorScreen extends StatefulWidget {
  @override
  _TextEditorScreenState createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  final TextEditingController _controller = TextEditingController();
  String fontStyle = 'Calibri';
  double fontSize = 12;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderlined = false;
  TextAlign _alignment = TextAlign.left;
  String? _imageUrl;
  String? _linkUrl;

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  Future<void> _loadSavedText() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/editor_text.html');
      if (await file.exists()) {
        final savedText = await file.readAsString();
        setState(() {
          _controller.text = savedText;
        });
      }
    } catch (e) {
      print("Error loading text: $e");
    }
  }

  Future<void> _saveText() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/editor_text.html');
      String htmlContent = '''
<!DOCTYPE html>
<html>
<head>
  <style>
    body { font-family: $fontStyle; font-size: ${fontSize}px; }
    .bold { font-weight: bold; }
    .italic { font-style: italic; }
    .underline { text-decoration: underline; }
    .left { text-align: left; }
    .center { text-align: center; }
    .right { text-align: right; }
  </style>
</head>
<body class="${_alignment == TextAlign.center ? 'center' : _alignment == TextAlign.right ? 'right' : 'left'}">
  ${_controller.text}
  ${_imageUrl != null ? '<img src="$_imageUrl" alt="Inserted Image" style="max-width: 100%;">' : ''}
  ${_linkUrl != null ? '<a href="$_linkUrl">Click here</a>' : ''}
</body>
</html>
''';
      await file.writeAsString(htmlContent);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Text saved as HTML successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving text: $e')),
      );
    }
  }

  void _toggleBold() {
    setState(() {
      _isBold = !_isBold;
    });
  }

  void _toggleItalic() {
    setState(() {
      _isItalic = !_isItalic;
    });
  }

  void _toggleUnderline() {
    setState(() {
      _isUnderlined = !_isUnderlined;
    });
  }

  void _setAlignment(TextAlign alignment) {
    setState(() {
      _alignment = alignment;
    });
  }

  void _addImage() async {
    final urlController = TextEditingController();
    final url = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter Image URL'),
        content: TextField(
          controller: urlController,
          decoration:
              InputDecoration(hintText: 'https://example.com/image.jpg'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, urlController.text),
            child: Text('OK'),
          ),
        ],
      ),
    );
    if (url != null && url.isNotEmpty) {
      setState(() {
        _imageUrl = url;
      });
    }
  }

  void _addLink() async {
    final urlController = TextEditingController();
    final url = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter Link URL'),
        content: TextField(
          controller: urlController,
          decoration: InputDecoration(hintText: 'https://example.com'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, urlController.text),
            child: Text('OK'),
          ),
        ],
      ),
    );
    if (url != null && url.isNotEmpty) {
      setState(() {
        _linkUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Editor'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveText,
          ),
        ],
      ),
      body: Column(
        children: [
          // Toolbar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            color: Colors.grey[200],
            height: 48, // fixed ছোট height
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DropdownButton<String>(
                    value: fontStyle,
                    items: <String>['Calibri', 'Arial', 'Times New Roman']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        fontStyle = newValue!;
                      });
                    },
                  ),
                  SizedBox(width: 4),
                  DropdownButton<double>(
                    value: fontSize,
                    items: [12.0, 14.0, 16.0, 18.0, 20.0]
                        .map<DropdownMenuItem<double>>((double value) {
                      return DropdownMenuItem<double>(
                        value: value,
                        child: Text('$value', style: TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (double? newValue) {
                      setState(() {
                        fontSize = newValue!;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.format_bold, size: 20),
                    onPressed: _toggleBold,
                    color: _isBold ? Colors.black : Colors.grey,
                  ),
                  IconButton(
                    icon: Icon(Icons.format_italic, size: 20),
                    onPressed: _toggleItalic,
                    color: _isItalic ? Colors.black : Colors.grey,
                  ),
                  IconButton(
                    icon: Icon(Icons.format_underlined, size: 20),
                    onPressed: _toggleUnderline,
                    color: _isUnderlined ? Colors.black : Colors.grey,
                  ),
                  IconButton(
                    icon: Icon(Icons.image, size: 20),
                    onPressed: _addImage,
                  ),
                  IconButton(
                    icon: Icon(Icons.link, size: 20),
                    onPressed: _addLink,
                  ),
                  DropdownButton<TextAlign>(
                    value: _alignment,
                    items: [
                      DropdownMenuItem(
                        value: TextAlign.left,
                        child: Text('Left'),
                      ),
                      DropdownMenuItem(
                        value: TextAlign.center,
                        child: Text('Center'),
                      ),
                      DropdownMenuItem(
                        value: TextAlign.right,
                        child: Text('Right'),
                      ),
                    ],
                    onChanged: (TextAlign? newValue) {
                      if (newValue != null) {
                        _setAlignment(newValue);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          // Text Input Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                textAlign: _alignment,
                decoration: InputDecoration(
                  hintText: 'Write here...',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  fontFamily: fontStyle,
                  fontSize: fontSize,
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                  decoration: _isUnderlined
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
