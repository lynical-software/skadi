import 'package:flutter/material.dart';

import '../../skadi.dart';

class WillPopDisable extends StatelessWidget {
  final Widget child;

  final bool canPop;

  ///Disable pop screen
  const WillPopDisable({
    super.key,
    required this.child,
    this.canPop = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: child,
    );
  }
}

class WillPopPrompt extends StatelessWidget {
  final Widget child;
  final ValueChanged<bool>? onResult;
  final Widget? popupChild;

  ///Show a dialog prompt when user trying to exit the Page while LoadingOverlay is currently displaying
  const WillPopPrompt({
    super.key,
    required this.child,
    this.onResult,
    this.popupChild,
  });

  @override
  Widget build(BuildContext context) {
    Future<bool> canPop() async {
      bool isLoading = LoadingOverlayProvider.instance.isLoading;
      if (isLoading) {
        LoadingOverlayProvider.switchPosition(LoadingOverlayPosition.below);
        bool? result = await showDialog(
          context: context,
          builder: (context) {
            return popupChild ??
                const WillPopDisable(
                  child: SkadiConfirmationDialog.danger(
                    content: Text(
                      "Are you sure you want to cancel this operation?",
                    ),
                    confirmText: "Cancel",
                    cancelText: "Discard",
                  ),
                );
          },
        );
        if (result == true) {
          LoadingOverlayProvider.toggle(false);
        }
        LoadingOverlayProvider.switchPosition(LoadingOverlayPosition.above);
        final pop = result ?? false;
        onResult?.call(pop);
        return pop;
      } else {
        onResult?.call(true);
      }
      return true;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          bool result = await canPop();
          if (result && context.mounted) {
            Navigator.pop(context);
          }
        }
      },
      child: child,
    );
  }
}
