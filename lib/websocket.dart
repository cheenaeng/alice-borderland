import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void initConnection() {
  const urlServer = 'ws://34.83.22.27';
  print('connection starts on' + urlServer);
  WebSocketChannel channel = IOWebSocketChannel.connect(urlServer);
}

//listen to messages from the server 

