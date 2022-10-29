import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:super_island/src/game/battle_game.dart';
import 'package:super_island/src/providers/battle_provider.dart';

class BattleSoundComponent extends PositionComponent
    with HasGameRef<BattleGame>, TapCallbacks {
  late SpriteComponent _spriteComponent;
  late Sprite _soundOn;
  late Sprite _soundOff;

  @override
  Future<void>? onLoad() async {
    debugMode = false;
    size = Vector2.all(88);
    position =
        Vector2(gameRef.size.x - gameRef.size.y / 8, gameRef.size.y / 50);
    scale = Vector2.all(88 * gameRef.size.y / 70000);
    _soundOn = await Sprite.load('icons/button_sound_on.png');
    _soundOff = await Sprite.load('icons/button_sound_off.png');
    _spriteComponent = SpriteComponent()
      ..sprite = _soundOn
      ..size = size;
    await add(_spriteComponent);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    _toggleAudio();
    super.onTapUp(event);
  }

  Future<void> _toggleAudio() async {
    if (_spriteComponent.sprite == _soundOff) {
      await gameRef.ref.read(battleProvider.notifier).toggleAudio();
      _spriteComponent.sprite = _soundOn;
      return;
    }
    await gameRef.ref
        .read(battleProvider.notifier)
        .toggleAudio(playAudio: false);
    _spriteComponent.sprite = _soundOff;
  }
}
