import 'package:ed25519_key_pair/ed25519_key_pair.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cryptography/cryptography.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smssos/classes/data_base.dart';
import 'package:smssos/classes/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart'; // Import this for compute

Future<void> init() async {

  generateAndSaveKeyPair();
  createDatabase();



}

Future<void> tests() async {
  final appDatabase = AppDataBase();
  await appDatabase.init();
}


Future<void> createDatabase() async {
  final appDatabase = AppDataBase();
  await appDatabase.init();
  print("After generating database");

}
Future<void> generateAndSaveKeyPair() async {
  final keyPair = await Ed25519KeyPair.generateKeyPair();

  final publicBase64 = base64Encode(keyPair.publicKey.bytes);
  final privateBase64 = base64Encode(await keyPair.privateKey.extractPrivateKeyBytes());

  print('Public Key: $publicBase64');
  print('Private Key: $privateBase64');

  // Save keys to secure storage
  final secureStorage = FlutterSecureStorage();
  await secureStorage.write(key: 'appPublicKey', value: publicBase64);
  await secureStorage.write(key: 'appPrivateKey', value: privateBase64);

  print('Keys saved to secure storage.');
}


