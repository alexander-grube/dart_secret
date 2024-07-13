class SecretResponse {
  SecretResponse(this.uuid, this.message);

  factory SecretResponse.fromJson(Map<String, dynamic> json) {
    return SecretResponse(
      json['uuid'] as String,
      json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'message': message,
    };
  }

  String uuid;
  String message;
}

class SecretRequest {
  SecretRequest(this.message);

  factory SecretRequest.fromJson(Map<String, dynamic> json) {
    return SecretRequest(
      json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }

  String message;
}
