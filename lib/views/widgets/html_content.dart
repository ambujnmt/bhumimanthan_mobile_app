import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

class HtmlContent extends StatelessWidget {
  final String data;

  const HtmlContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final document = html_parser.parse(data);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          document.body?.nodes
              .map((node) => _buildNode(node, context))
              .whereType<Widget>()
              .toList() ??
          [],
    );
  }

  Widget? _buildNode(dom.Node node, BuildContext context) {
    if (node is dom.Text) {
      final text = node.text.trim();

      if (text.isEmpty) return null;

      return Text(text);
    }

    if (node is! dom.Element) return null;

    final children = node.nodes
        .map((child) => _buildNode(child, context))
        .whereType<Widget>()
        .toList();

    switch (node.localName) {
      case 'h1':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            node.text.trim(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        );

      case 'h2':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            node.text.trim(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );

      case 'h3':
        return Text(
          node.text.trim(),
          style: Theme.of(context).textTheme.titleMedium,
        );

      case 'p':
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(node.text.trim()),
        );

      case 'strong':
      case 'b':
        return Text(
          node.text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        );

      case 'em':
      case 'i':
        return Text(
          node.text,
          style: const TextStyle(fontStyle: FontStyle.italic),
        );

      case 'br':
        return const SizedBox(height: 8);

      case 'ul':
      case 'ol':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );

      case 'li':
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('•  '),
              Expanded(child: Text(node.text.trim())),
            ],
          ),
        );

      case 'div':
      case 'body':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );

      default:
        return children.isEmpty
            ? Text(node.text.trim())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              );
    }
  }
}
