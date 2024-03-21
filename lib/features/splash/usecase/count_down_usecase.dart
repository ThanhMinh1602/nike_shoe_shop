class CountDownUseCase {
  Future<void> call() async {
    return await Future.delayed(const Duration(seconds: 2));
  }
}
