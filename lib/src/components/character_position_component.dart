import 'package:flame/components.dart';
import 'package:super_island/src/components/battle_shadow_component.dart';
import 'package:super_island/src/components/character_component.dart';
import 'package:super_island/src/components/damage_component.dart';
import 'package:super_island/src/components/empty_bar_component.dart';
import 'package:super_island/src/enums/bar_enum.dart';
import 'package:super_island/src/game/battle_game.dart';

class CharacterPositionComponent extends PositionComponent
    with HasGameRef<BattleGame> {
  CharacterPositionComponent({
    required this.character,
    required this.characterPosition,
    required this.characterPriority,
    this.isFlip = false,
  }) : super() {
    debugMode = false;
  }

  final CharacterComponent character;
  final int characterPosition;
  final int characterPriority;
  final bool isFlip;

  late EmptyBarComponent _lifeBar;
  late EmptyBarComponent _rageBar;
  TextComponent? _textComponent;
  Vector2 starterPosition = Vector2.all(0);

  @override
  Future<void>? onLoad() async {
    size = Vector2(256, 224);
    scale = Vector2.all(gameRef.size.y / 800);
    priority = characterPriority;
    _setPosition();
    starterPosition = Vector2(x, y);
    if (isFlip) {
      flipHorizontallyAroundCenter();
    }
    await add(BattleShadowComponent(size));
    await add(character);
    await _addLifeBar();
    await _addRageBar();
    return super.onLoad();
  }

  Future<void> setDamage({bool flip = false}) async {
    _textComponent = DamageComponent(flip: flip);
    if (_textComponent?.parent != null) {
      remove(_textComponent!);
    }
    await add(_textComponent!);
  }

  void removeDamage() {
    if (_textComponent?.parent != null) {
      remove(_textComponent!);
    }
  }

  void changeLife(int size) {
    _lifeBar.changeLife(size);
  }

  void toggleBar({bool isShow = true}) {
    _lifeBar.toggleBar(isShow: isShow);
    _rageBar.toggleBar(isShow: isShow);
  }

  void changeRage(int size) {
    _rageBar.changeRage(size);
  }

  void _setPosition() {
    switch (characterPosition) {
      case 1:
        position.x = gameRef.size.x / 5;
        position.y = gameRef.size.y / 6;
        break;
      case 2:
        position.x = gameRef.size.x / 5;
        position.y = gameRef.size.y / 3;
        break;
      case 3:
        position.x = gameRef.size.x / 5;
        position.y = gameRef.size.y / 2;
        break;
      case 4:
        position.x = gameRef.size.x / 11;
        position.y = gameRef.size.y / 6;
        break;
      case 5:
        position.x = gameRef.size.x / 11;
        position.y = gameRef.size.y / 3;
        break;
      case 6:
        position.x = gameRef.size.x / 11;
        position.y = gameRef.size.y / 2;
        break;
      case 7:
        position.x = gameRef.size.x / 1.66;
        position.y = gameRef.size.y / 6;
        break;
      case 8:
        position.x = gameRef.size.x / 1.66;
        position.y = gameRef.size.y / 3;
        break;
      case 9:
        position.x = gameRef.size.x / 1.66;
        position.y = gameRef.size.y / 2;
        break;
      case 10:
        position.x = gameRef.size.x / 1.4;
        position.y = gameRef.size.y / 6;
        break;
      case 11:
        position.x = gameRef.size.x / 1.4;
        position.y = gameRef.size.y / 3;
        break;
      case 12:
        position.x = gameRef.size.x / 1.4;
        position.y = gameRef.size.y / 2;
        break;
      default:
    }
  }

  Future<void> _addLifeBar() async {
    _lifeBar = EmptyBarComponent(
      bar: BarEnum.life,
      barScale: Vector2.all(size.y / 200),
      barPosition: Vector2(size.x / 3.5, size.y - size.y),
      flip: isFlip,
    );
    await add(_lifeBar);
  }

  Future<void> _addRageBar() async {
    _rageBar = EmptyBarComponent(
      barScale: Vector2(size.y / 200, size.y / 300),
      barPosition: Vector2(size.x / 3.5, size.y / 20),
      bar: BarEnum.rage,
      flip: isFlip,
    );
    await add(_rageBar);
  }
}
