// import 'package:flutter/material.dart';
// import 'package:ride_fizz_app/core/api/base_repository.dart';

// class ApiErrorMapper {
//   static void handle(
//     BuildContext context,
//     ApiError error, {
//   }) {
//     switch (error.type) {
//       case ApiErrorType.network:
//         _snack(context, 'No internet connection');
//         break;

//       case ApiErrorType.timeout:
//         _snack(context, 'Request timed out. Please try again.');
//         break;

//       case ApiErrorType.validation:
//         _snack(context, error.message);
//         break;

//       case ApiErrorType.forbidden:
//         _snack(context, 'You don’t have permission to perform this action.');
//         break;

//       case ApiErrorType.notFound:
//         _snack(context, 'Requested resource not found.');
//         break;

//       case ApiErrorType.server:
//         _snack(context, 'Server error. Please try later.');
//         break;

//       case ApiErrorType.unauthorized:
//         _snack(context, 'You are not authorized to perform this action.');
//         break;
//       case ApiErrorType.unknown:
//         _snack(context, 'Something went wrong.');
//         break;
//     }
//   }

//   static void _snack(BuildContext context, String message) {
//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
//       );
//   }
// }
