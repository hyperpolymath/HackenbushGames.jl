# TEST-NEEDS: HackenbushGames.jl

## Current State

| Category | Count | Details |
|----------|-------|---------|
| **Source modules** | 2 | 452 lines |
| **Test files** | 1 | 123 lines, 51 @test/@testset |
| **Benchmarks** | 0 | None |

## What's Missing

- [ ] **Performance**: No benchmarks for game tree search
- [ ] **Error handling**: No tests for invalid game states

## FLAGGED ISSUES
- **51 tests for 2 modules = 25.5 tests/module** -- adequate
- **0 benchmarks** for combinatorial game computation

## Priority: P3 (LOW)

## FAKE-FUZZ ALERT

- `tests/fuzz/placeholder.txt` is a scorecard placeholder inherited from rsr-template-repo — it does NOT provide real fuzz testing
- Replace with an actual fuzz harness (see rsr-template-repo/tests/fuzz/README.adoc) or remove the file
- Priority: P2 — creates false impression of fuzz coverage
