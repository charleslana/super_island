import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:super_island/src/components/life_bar_component.dart';
import 'package:super_island/src/components/rage_bar_component.dart';
import 'package:super_island/src/enums/bar_enum.dart';
import 'package:super_island/src/game/battle_game.dart';

class EmptyBarComponent extends PositionComponent
    with HasGameRef<BattleGame>, HasPaint {
  EmptyBarComponent({
    required this.bar,
    required this.barScale,
    required this.barPosition,
    this.flip = false,
  }) : super() {
    debugMode = false;
  }

  final BarEnum bar;
  final Vector2 barScale;
  final Vector2 barPosition;
  final bool flip;

  SpriteComponent _spriteComponent = SpriteComponent();
  LifeBarComponent _life = LifeBarComponent();
  RageBarComponent _rage = RageBarComponent();

  @override
  Future<void>? onLoad() async {
    _spriteComponent = SpriteComponent()
      ..sprite = await Sprite.load('bar/bar_empty.png')
      ..size = Vector2(100, 10)
      ..position = barPosition
      ..scale = barScale;
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
        _life = LifeBarComponent();
        await _spriteComponent.add(_life);
        break;
      case BarEnum.rage:
        _rage = RageBarComponent();
        await _spriteComponent.add(_rage);
        break;
      default:
    }
  }

  void changeLife(int size) {
    _life.changeSize(size);
  }

  void changeRage(int size) {
    _rage.changeSize(size);
  }

  void toggleBar({bool isShow = true}) {
    if (!isShow) {
      _spriteComponent
          .add(OpacityEffect.fadeOut(EffectController(duration: 0)));
      _life.toggleBar(isShow: isShow);
      _rage.toggleBar(isShow: isShow);
      return;
    }
    _spriteComponent.add(OpacityEffect.fadeIn(EffectController(duration: 0)));
    _life.toggleBar(isShow: isShow);
    _rage.toggleBar(isShow: isShow);
  }
}
