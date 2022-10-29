import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class LifeBarComponent extends PositionComponent with HasPaint {
  LifeBarComponent() : super() {
    debugMode = false;
  }

  late SpriteComponent _spriteComponent;
  late Sprite _greenSprite;
  late Sprite _redSprite;

  @override
  Future<void>? onLoad() async {
    _greenSprite = await Sprite.load('bar/bar_hp.png');
    _redSprite = await Sprite.load('bar/bar_hp1.png');
    _spriteComponent = SpriteComponent()
      ..sprite = _greenSprite
      ..size = Vector2(100, 10);
    await add(_spriteComponent);
    return super.onLoad();
  }

  void changeSize() {
    if (_spriteComponent.size.x > 0) {
      _spriteComponent.size.x -= 25;
      if (_spriteComponent.size.x <= 25) {
        _spriteComponent.sprite = _redSprite;
      }
      return;
    }
    _spriteComponent.size.x = 100;
    _spriteComponent.sprite = _greenSprite;
  }

  void toggleBar({bool isShow = true}) {
    if (isShow) {
      _spriteComponent
          .add(OpacityEffect.fadeOut(EffectController(duration: 0)));
      return;
    }
    _spriteComponent.add(OpacityEffect.fadeIn(EffectController(duration: 0)));
  }
}
