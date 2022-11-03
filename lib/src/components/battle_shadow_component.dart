import 'package:flame/components.dart';

class BattleShadowComponent extends PositionComponent {
  BattleShadowComponent(this.refSize) : super() {
    debugMode = false;
  }

  final Vector2 refSize;

  late SpriteComponent _spriteComponent;

  @override
  Future<void>? onLoad() async {
    size = Vector2(85, 53);
    scale = Vector2.all(refSize.y / 250);
    position = Vector2(refSize.x / 2.7, refSize.y / 1.3);
    _spriteComponent = SpriteComponent()
      ..sprite = await Sprite.load('characters/shadow.png')
      ..size = size;
    await add(_spriteComponent);
    return super.onLoad();
  }
}
