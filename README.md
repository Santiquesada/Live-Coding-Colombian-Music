# Live Coding with Colombian Music

A live coding system in [ChucK](https://chuck.stanford.edu/) built around the rhythmic
patterns and phrasing of Colombian traditional music (currulao, bullerengue, bunde,
cumbia), with Afro-Cuban percussion as a related reference.

It originates in my master's thesis, *Live Coding con Sabor a Músicas Colombianas*
(2024), and has since grown to include neural models running live inside ChucK via ONNX.

**Performance video (EulerRoom):** https://youtu.be/1UwBMnd7eY8

---

## How it works

Every instrument class exposes the same call:

```chuck
instrument.play(Beat, percentage, type, Notes[]);
```

- `Beat` — duration of one subdivision, in seconds.
- `type` — phrasing model (`Phrasing.ck`): `0` = straight, `1` = binary
  (first note of each pair longer), `2` = ternary (first two notes of each group of
  three longer).
- `percentage` — how much the long notes are stretched (and the short ones shortened).
- `Notes[]` — the pattern; negative markers group notes into half-length subdivisions.

`synch.cycle(Beats, Beat)` waits for the next bar boundary, so new code entered during a
performance lands in time; `synch.hush()` clears previous layers.

## Running it

1. Open `Library.ck` in miniAudicle (or `chuck Library.ck`) and add it — this loads the
   phrasing engine, synchronization and all instruments.
2. Add any piece from `pieces/` (e.g. `pieces/Murga Tumaco.ck`) and edit it live.

Some pieces use additional classes not loaded by `Library.ck` (e.g. `Rhythms.ck`,
`Modes.ck`); add those first if ChucK reports an undefined type.

## Repository layout

| Path | Contents |
|---|---|
| `Library.ck` | Entry point: loads the engine and instruments |
| `Phrasing.ck`, `Synch.ck` | Binary/ternary phrasing model and bar synchronization |
| `*.ck` (root) | Instrument classes: marimba, balafon, drums (Colombian and Cuban kits), bass, synths, MIDI input |
| `pieces/` | Compositions and performance templates |
| `ai/` | Neural generators running live in ChucK (see below) |
| `onnx/` | Exported models for ChAR |
| `Samples/` | Percussion and marimba samples (cununo, bombo, tambora, llamador, alegre, marimba, Cuban kit, udu) |
| `visuals/` | TouchDesigner patches used for visuals in performance |

## Neural extensions (`ai/`)

- **CurrulaoGRU** — a GRU that predicts the next marimba phrase in currulao, conditioned
  on the previous four phrases and their harmonic states (tonic/dominant). Trained on
  transcriptions of Baudilio Cuama and Marino Beltrán (*Arrullos y Currulaos*). Runs
  live through **Chonnx**, a generic ONNX Runtime chugin for ChucK.
- **CurrulaoAI** — an earlier MLP version of the same idea, kept for comparison.
- **ChAR** — a Transformer jazz melody generator running in ChucK (`ChAR-*.ck`,
  `ChARMel.ck`, `ChARMar.ck`).

> Note: the Chonnx chugin and the currulao models are not yet published; the `ai/`
> pieces expect them in a sibling `Chonnx_Training/` folder.

## Author

Santiago Quesada — musician, live coder and electronic engineer.
