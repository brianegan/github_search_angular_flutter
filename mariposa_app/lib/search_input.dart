import 'dart:html' show KeyboardEvent, InputElement;

import 'package:html_builder/elements.dart';
import 'package:mariposa/mariposa.dart';
import 'package:meta/meta.dart';

Node SearchInput({@required void Function(String) onTextChanged}) {
  return Div(children: [
    label(for_: 'term', className: 'clip', c: [Text('Enter a search term')]),
    TextInput(
      id: 'term',
      placeholder: 'Enter a search term',
      autofocus: true,
      className:
          'input-reset outline-transparent glow o-50 bg-near-black near-white w-100 pv2 border-box b--white-50 br-0 bl-0 bt-0 bb-ridge mb3',
      eventListeners: {
        'keyup': (event) {
          if (event is KeyboardEvent) {
            onTextChanged((event.target as InputElement).value);
          }
        }
      },
    ),
  ]);
}

class TextInput extends HtmlWidget {
  TextInput(
      {String id,
      String className,
      Style style,
      String placeholder = '',
      bool autofocus = false,
      Map<String, dynamic> props,
      Map<String, void Function(Object)> eventListeners,
      Iterable<Node> children})
      : super(
          'input',
          id,
          className,
          style,
          {
            'type': 'text',
            'placeholder': placeholder,
            'autofocus': autofocus,
          },
          eventListeners,
          children,
        );
}
