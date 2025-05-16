import 'package:flutter/material.dart';

class FutureBuilderWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final bool Function(T? data)? isEmpty;

  const FutureBuilderWidget({
    super.key,
    required this.future,
    required this.builder,
    this.loadingWidget,
    this.emptyWidget,
    this.errorWidget,
    this.isEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ??
              const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return errorWidget ?? Center(child: Text('Error: ${snapshot.error}'));
        }

        final data = snapshot.data;
        final emptyCondition = isEmpty != null ? isEmpty!(data) : data == null;

        if (emptyCondition) {
          return emptyWidget ?? const Center(child: Text('No data found.'));
        }

        return builder(context, data as T);
      },
    );
  }
}
