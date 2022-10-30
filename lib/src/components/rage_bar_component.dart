import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class RageBarComponent extends PositionComponent with HasPaint {
  RageBarComponent() : super() {
    debugMode = false;
  }

  SpriteComponent _spriteComponent = SpriteComponent();

  @override
  Future<void>? onLoad() async {
    _spriteComponent = SpriteComponent()
      ..sprite = await Sprite.load('bar/bar_rage.png')
      ..size = Vector2(0, 10);
    await add(_spriteComponent);
    return super.onLoad();
  }

  void changeSize(int size) {
    if (_spriteComponent.size.x < 100) {
      _spriteComponent.size.x += size;
      return;
    }
    _spriteComponent.size.x = 0;
  }

  void toggleBar({bool isShow = true}) {
    if (!isShow) {
      _spriteComponent
          .add(OpacityEffect.fadeOut(EffectController(duration: 0)));
      return;
    }
    _spriteComponent.add(OpacityEffect.fadeIn(EffectController(duration: 0)));
  }
}
