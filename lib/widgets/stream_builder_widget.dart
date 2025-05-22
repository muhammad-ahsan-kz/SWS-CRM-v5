import 'package:flutter/material.dart';
import 'package:sws_crm_v5/widgets/loading_animation_widget.dart';

class StreamBuilderWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) builder;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final bool Function(T? data)? isEmpty;

  const StreamBuilderWidget({
    super.key,
    required this.stream,
    required this.builder,
    this.loadingWidget,
    this.emptyWidget,
    this.errorWidget,
    this.isEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ?? const Center(child: LoadingAnimationWidget());
        }

        if (snapshot.hasError) {
          return errorWidget ?? Center(child: Text('Error: ${snapshot.error}'));
        }

        final data = snapshot.data;

        // final emptyCondition = isEmpty != null ? isEmpty!(data) : data == null;

        bool emptyCondition = false;

        if (isEmpty != null) {
          // If a custom isEmpty function is provided
          emptyCondition = isEmpty!(data);
        } else if (data == null) {
          emptyCondition = true;
        } else if (data is Iterable && data.isEmpty) {
          emptyCondition = true;
        } else if (data is Map && data.isEmpty) {
          emptyCondition = true;
        }

        if (emptyCondition) {
          return emptyWidget ?? const Center(child: Text('No data found.'));
        }

        return builder(context, data as T);
      },
    );
  }
}
