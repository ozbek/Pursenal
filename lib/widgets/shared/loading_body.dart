import 'package:flutter/material.dart';
import 'package:pursenal/core/enums/loading_status.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody(
      {super.key,
      required this.loadingStatus,
      required this.errorText,
      required this.widget,
      this.feedbackText = "",
      required this.resetErrorTextFn});
  final LoadingStatus loadingStatus;
  final String errorText;
  final String feedbackText;
  final Widget widget;
  final Function resetErrorTextFn;

  @override
  Widget build(BuildContext context) {
    if (loadingStatus == LoadingStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (loadingStatus == LoadingStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_sharp,
              size: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorText,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            IconButton.filled(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))
          ],
        ),
      );
    }

    //  else if (loadingStatus == LoadingStatus.submitting) {
    //   return Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         CircularProgressIndicator(),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //             AppLocalizations.of(context)!.submitting,
    //             style: Theme.of(context).textTheme.bodyLarge,
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // else if (loadingStatus == LoadingStatus.submitted) {
    //   return Builder(
    //     builder: (context) {
    //       // Use addPostFrameCallback to avoid calling Navigator.pop inside build
    //       WidgetsBinding.instance.addPostFrameCallback((_) {
    //         if (Navigator.canPop(context)) {
    //           Navigator.pop(context);
    //         }
    //       });
    //       return const SizedBox(); // Return an empty widget while pop is in progress
    //     },
    //   );
    // }

    if (errorText.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorText)),
        );
        resetErrorTextFn();
      });
    }

    if (feedbackText.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(feedbackText)),
        );
        resetErrorTextFn();
      });
    }

    return widget;
  }
}
