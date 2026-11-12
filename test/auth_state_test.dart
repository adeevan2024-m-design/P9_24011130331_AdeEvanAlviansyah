import 'package:flutter_test/flutter_test.dart';
import 'package:toko_app/state/auth_state.dart';

void main() {
  test('login stores a trimmed username and logout clears the session', () {
    final authState = AuthState();
    addTearDown(authState.dispose);

    authState.login('  Ayu  ');
    expect(authState.isLoggedIn, isTrue);
    expect(authState.isAdmin, isFalse);
    expect(authState.username, 'Ayu');

    authState.logout();
    expect(authState.isLoggedIn, isFalse);
    expect(authState.isAdmin, isFalse);
    expect(authState.username, isEmpty);
  });

  test('only the admin username has admin access', () {
    final authState = AuthState();
    addTearDown(authState.dispose);

    authState.login('admin');
    expect(authState.isAdmin, isTrue);

    authState.login('Admin');
    expect(authState.isAdmin, isFalse);
  });

  test('login rejects an empty username', () {
    final authState = AuthState();
    addTearDown(authState.dispose);

    expect(() => authState.login(' '), throwsArgumentError);
    expect(authState.isLoggedIn, isFalse);
  });
}
