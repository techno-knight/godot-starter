# Godot 4 2D Mobile Starter Kit

A production-ready, highly scalable Godot 4 2D starter project optimized for mobile (Android/iOS).

## Architecture Highlights

- **Component Pattern:** Relies heavily on `HealthComponent`, `HitboxComponent`, `HurtboxComponent` for data-driven composition rather than massive inheritance trees.
- **Signal Bus:** The global `SignalBus` autoload completely decouples systems. The HUD doesn't need to know the Player exists; it just listens to `SignalBus.score_updated`.
- **State Machine:** Robust generic FSM implementation in `core/fsm/` makes complex AI and Player behavior manageable.
- **Threaded Loading:** The `SceneLoader` uses `ResourceLoader.load_threaded_request` to load 50+ scene levels without halting the main thread.
- **Global Object Pooling:** Built-in `PoolManager` Autoload to globally manage bullets, effects, and frequently spawned objects without cluttering the scene tree.

## Directory Structure

- `res://autoload/`: Global singletons (`GameManager`, `SceneLoader`, `SignalBus`).
- `res://core/`: System logic, reusable node components, FSM base scripts.
- `res://scenes/`: Game entities composed of components (`Player`, `Enemy`).
- `res://levels/`: Level layout scenes.
- `res://resources/`: Typed data storage (e.g. `SaveData.gd`).
- `res://ui/`: UI screens (HUD, Menus, Pause).

## How to add a new Level

1. Create a new inherited scene from `Level_01.tscn` or a new `Node2D`.
2. Add your environment, spawn your `Player.tscn` and `Enemy.tscn`.
3. Add a `CanvasLayer` with the `HUD` and `PauseMenu`.
4. Update `MainMenu.gd` to load your new level path.

## How to run tests

To run the custom test runner headlessly from the command line:

```bash
godot --no-window -s res://tests/SimpleTestRunner.gd
```

## Performance Tips

- Use the provided `ObjectPool` instead of `queue_free` and `instantiate` during heavy combat to avoid stuttering on low-end mobile devices.
- `Renderer` is set to `mobile` for maximum performance on modern phones. If targeting very old web or low-end devices, change to `gl_compatibility`.
