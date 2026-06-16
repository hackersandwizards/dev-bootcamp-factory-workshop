# Factory instrumentation: close the loop

Use this after the Day 2 morning exercises (observability, evals, learning
loops). Your factory already sees its runs: the trace hook has been logging to
runs/trace.jsonl since Day 1. This step adds the other two moves: evals that
tell a good Bean from a bad one, and one guard that runs automatically so a
failure you found once cannot recur.

## Evals: test your factory's output

1. Copy the eval kit into your project:

   ```bash
   cp -R <path-to>/take-home/instrument/eval-kit .
   ```

2. Run it on a good Bean and a bad one. Use your own: a Bean from a clean slot-2
   run is your good one. Make a broken copy by hand (delete the Refined Plan, or
   weaken the acceptance criteria to "it works").

   ```bash
   bash eval-kit/check.sh .beans/<your-good-bean>.md
   bash eval-kit/check.sh /tmp/<your-broken-bean>.md
   ```

   A useful eval passes the good Bean and fails the broken one. If it passes
   both, sharpen it.

3. Add a couple of checks aimed at the failure modes that would hurt your real
   factory most. The "your turn" section in check.sh shows the shape.

A metric that matters more than structure: acceptance-criteria coverage. Does
every acceptance criterion the planner wrote have a test that exercises it? Score
it covered over total, and for the subjective part ("are these criteria
measurable?") ask an independent agent to judge, validated on a good and a vague
Bean first. Keep it light: run the metric, fix one gap, run it again. Two or
three cycles, not a suite.

## Guard: make one eval run every time

Pick the escape you found when you red-teamed your factory. Wire a deterministic
check into the implement station so it runs on every implement, not by hand.

The shipped example guards the most common escape: a Bean reaching code with no
Refined Plan. Add this to the top of implement's Phase 1 preflight:

```
Run the factory's guards before touching anything:

    bash guards/require-refined-plan.sh <bean-id> || exit 1

If a guard fails, abort. Do not create a branch, do not edit source.
```

Adapt require-refined-plan.sh for the escape you actually found.

## Codify: write the lesson down

Add one line to CLAUDE.md under ## Lessons: name the check and the signal it
watches. That is what makes the lesson survive past today.

## What is in here

```
eval-kit/check.sh                deterministic checks on a Bean (PASS/FAIL)
guards/require-refined-plan.sh   example guard for implement's preflight
```
