/// Network connectivity information
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation of NetworkInfo using internet_connection_checker package
class NetworkInfoImpl implements NetworkInfo {
  // final InternetConnectionChecker connectionChecker;

  // NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
    // return await connectionChecker.hasConnection;
    // TODO: Implement with internet_connection_checker or connectivity_plus
    return true;
  }
}
