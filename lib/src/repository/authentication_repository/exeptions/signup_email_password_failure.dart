class PExecptions {
  final String message;

  const PExecptions([this.message = "An Unexpected Error Occurred."]);

  factory PExecptions.code(String code) {
    switch (code) {
      case "email-already-in-use":
        return const PExecptions("The email is already in use.");
      case "invalid-email":
        return const PExecptions("The email is invalid.");

      case "weak-password":
        return const PExecptions("The password is too weak.");
      case "user-disabled":
        return const PExecptions(
            "The user is disabled. Please Contact Support.");
      case "user-not-found":
        return const PExecptions("Invalid Details, please create an account.");
      case "wrong-password":
        return const PExecptions("Incorrect password, try again.");
      case "invalid-argument":
        return const PExecptions(
            "An invalid argument was provided to an Authentication method.");
      case "invalid-password":
        return const PExecptions("Incorrect password, try again.");
      case "uid-already-exist":
        return const PExecptions(
            "The provided uid is already in use by an existing user");

      case "operation-not-allowed":
        return const PExecptions("The operation is not allowed.");
      default:
        return const PExecptions();
    }
  }
}
