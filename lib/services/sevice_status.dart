enum SignupResult {
  success,
  emailAlreadyExists,
  failure,
  invalidEmail,
}

enum SigninResult {
  successIsUser,
  successIsAdmin,
  failure,
}

enum SendOrderStatus {
  success,
  failure,
}

enum ResetPasswordStatus {
  success,
  failure,
  emailNotFound,
}
