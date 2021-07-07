import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';



 class MQTTwrapper {
   String broker, username, key, topic1, topic2;
   int port;

   MQTTwrapper({
     this.topic1,
     this.topic2,
     this.broker,
     this.username,
     this.key,
     this.port
   });

  Future updateMQTT(String uSID, String uMMD) async {
    broker    = "io.adafruit.com";
    username  = "Rahul_P";
    key       = "5ace35f9f0a44b2e92efd57d41345c64"; 
    topic1    = "/feeds/MMD_ID";
    topic2    = "/feeds/SID";   
    port      = 1883;
    
    // Connect to server
    MqttServerClient client = MqttServerClient.withPort(broker, 'VTMS', port);
    client.logging(on: true);

    // Point to topic we want to send data to
    final sendMMD = MqttClientPayloadBuilder();
    final sendSID = MqttClientPayloadBuilder();
    sendMMD.addString(uSID);
    sendSID.addString(uMMD);

    // publish data
    client.publishMessage(topic1, MqttQos.atLeastOnce, sendSID.payload);
    client.publishMessage(topic2, MqttQos.atLeastOnce, sendMMD.payload);

     // disconnect
    client.disconnect();
  }

}
