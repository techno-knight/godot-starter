# Godot 2D Mobile Starter — Game Studio & Architecture Guidelines

This project uses the **Game Studios** framework (migrated from [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)) integrated into **Google Antigravity**.

## Active Engine & Configuration
- **Engine**: Godot 4.6 (Mobile profile)
- **Primary Language**: GDScript (Strict static typing mandatory)
- **Project Configuration**: `project.yaml`
- **Engine Reference**: `docs/engine-reference/godot/`

## Available Specialist Agents & Skills
- **Skills**: 78 Game Studio skills available (e.g. `/prototype`, `/start`, `/setup-engine`, `/create-stories`, `/dev-story`, `/gate-check`, `/code-review`, `/art-bible`, `/qa-plan`, etc.)
- **Subagents**: 49 domain specialists (e.g. `godot-specialist`, `godot-gdscript-specialist`, `godot-shader-specialist`, `game-designer`, `systems-designer`, `level-designer`, `qa-lead`, etc.)

## Architecture Standards
1. **Composition over Inheritance:** NEVER create deep inheritance chains. Always use the Component pattern (`HealthComponent`, `HitboxComponent`, `HurtboxComponent`). Attach components to base nodes to compose behavior.
2. **Global Signal Bus:** NEVER couple scenes directly. Use `autoload/SignalBus.gd` (e.g. HUD listens to `SignalBus.score_updated`).
3. **State Machines:** Use the FSM setup defined in `core/fsm/StateMachine.gd` and `core/fsm/State.gd`.
4. **Performance & Mobile:**
   - **Object Pooling:** DO NOT use `instantiate()` and `queue_free()` during active gameplay for frequent objects (bullets, particles, coins). Always use `autoload/PoolManager.gd`.
   - **Scene Loading:** Use `autoload/SceneLoader.gd` for threaded async loading to prevent mobile stutters.
5. **GDScript Strict Typing:** Explicit return types (`-> void`, `-> int`) and variable types (`var health: int = 100`).
6. **Typed Resources:** Use `SaveData.gd` and `autoload/SaveManager.gd` for game persistence.
