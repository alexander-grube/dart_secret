class Secret {
  Secret(this.message);

  factory Secret.fromJson(Map<String, dynamic> json) {
    return Secret(
      json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }

  final String message;
}
