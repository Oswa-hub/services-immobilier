class Routes {
  Routes._();

  static const splash = '/splash';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const resetPassword = '/reset-password';
  static const verifyEmail = '/verify-email';
  static const accountStatus = '/account-status';
  static const home = '/home';
  static const adminDashboard = '/admin/dashboard';

  /// Reachable while signed out.
  static const publicRoutes = {welcome, login, register, forgotPassword};
}
