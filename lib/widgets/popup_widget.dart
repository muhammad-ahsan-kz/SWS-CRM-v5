import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

enum NotificationType { success, error, info }

class NotificationService {
  static void show(
    BuildContext context, {
    required String message,
    NotificationType type = NotificationType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (_) => _NotificationToast(message: message, type: type),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}

class _NotificationToast extends StatefulWidget {
  final String message;
  final NotificationType type;

  const _NotificationToast({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  State<_NotificationToast> createState() => _NotificationToastState();
}

class _NotificationToastState extends State<_NotificationToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case NotificationType.success:
        return AppColors.primaryGreen;
      case NotificationType.error:
        return AppColors.red;
      case NotificationType.info:
      default:
        return AppColors.grey;
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case NotificationType.success:
        return Icons.check_circle_outline;
      case NotificationType.error:
        return Icons.error_outline;
      case NotificationType.info:
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 24,
      right: 24,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          color: _getBackgroundColor(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(_getIcon(), color: AppColors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
