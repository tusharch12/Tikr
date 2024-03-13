import 'package:audioplayers/audioplayers.dart';

class sound_effect {
  final player = AudioPlayer();
  void onPurchase_play() {
    player.play(AssetSource('purchase_effect.mp3'));
  }
}
