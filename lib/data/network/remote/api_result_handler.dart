abstract class ApiResults {}

class ApiSuccess extends ApiResults {
  dynamic data;
  int? statusCode;

  ApiSuccess(this.data, this.statusCode);
}

class ApiFailure extends ApiResults {
  dynamic message;
  int? statusCode;
  ApiFailure(this.message, {this.statusCode});
}
