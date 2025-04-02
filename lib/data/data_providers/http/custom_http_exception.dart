/// Http exception used in send custom exception during api call.
/// mostly used in send custom exception from repository and catch the exception in cubit.
class CustomHttpException{
  final String error;
  CustomHttpException( {required this.error});
}