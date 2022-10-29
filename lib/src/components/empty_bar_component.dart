import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:super_island/src/components/life_bar_component.dart';
import 'package:super_island/src/enums/bar_enum.dart';
import 'package:super_island/src/game/battle_game.dart';

class EmptyBarComponent extends PositionComponent
    with HasGameRef<BattleGame>, HasPaint {
  EmptyBarComponent({
    required this.bar,
    this.flip = false,
  }) : super() {
    debugMode = false;
  }

  final BarEnum bar;
  final bool flip;

  late SpriteComponent _spriteComponent;

  late LifeBarComponent life;

  @override
  Future<void>? onLoad() async {
    _spriteComponent = SpriteComponent()
      ..sprite = await Sprite.load('bar/bar_empty.png')
      ..size = Vector2(100, 10)
      ..position =
          Vector2(gameRef.size.y / 20, (-gameRef.size.y - gameRef.size.y) / 60)
      ..scale = Vector2.all(gameRef.size.y / 1000 * 2);
    if (flip) {
      _spriteComponent.flipHorizontallyAroundCenter();
    }
    await _addBar(bar);
    await add(_spriteComponent);
    return super.onLoad();
  }

  Future<void> _addBar(BarEnum bar) async {
    switch (bar) {
      case BarEnum.life:
        life = LifeBarComponent();
        await _spriteComponent.add(life);
        break;
      case BarEnum.fury:
        // await _spriteComponent.add(LifeBarComponent());
        break;
      default:
    }
  }

  void changeLife() {
    life.changeSize();
  }

  void toggleBar({bool isShow = true}) {
    if (isShow) {
      _spriteComponent
          .add(OpacityEffect.fadeOut(EffectController(duration: 0)));
      life.toggleBar(isShow: isShow);
      return;
    }
    _spriteComponent.add(OpacityEffect.fadeIn(EffectController(duration: 0)));
    life.toggleBar(isShow: isShow);
  }
}
