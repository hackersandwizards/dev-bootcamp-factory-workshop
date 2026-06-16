# Take it home: run your own factory

You spent the workshop building a planner, refine, implement factory against a
calculator. The calculator was the rig. The factory is the product. In these
sessions you point the same factory at a project you choose, then make it
improve. The skills are the ones you already built. Only the build and test
commands change.

Before you start, you need: Claude Code, the `beans` CLI, `jq`, and your
language's own toolchain (so there is a real build and test command to gate on).

## Pick a project

Anything pure and testable, ideally with something you can see. Logic in, value
out, no network, no files, no UI framework. That shape keeps a full plan, refine,
implement cycle short and the gate reliable.

Projects you can watch (ASCII output):

- Conway's Game of Life, a grid that animates. Suggested default; a scaffold
  prompt is in starter/README.md.
- Tic-tac-toe with a simple AI opponent. The board is the screen; the win check
  and the move choice are pure.
- An ASCII bar chart or sparkline renderer. render(data) returns a string, so
  the output is the test.
- A maze generator and solver, drawn with walls and a path.

Pure-logic projects (fastest, crispest tests):

- Roman numerals, to and from integers.
- A text-utilities library: slugify, wrap, word count.
- An in-memory todo list or shopping cart model.

Or a real repo you brought, if it is small and already has a test command.

One project per pod is enough to present. Pick a first feature small enough to
plan, refine and implement in half an hour.

## Languages that work well

The factory is language-agnostic. A language fits well here when its tests are
fast and hermetic, it has a real test runner, and your pod knows it. Set the two
commands below in CLAUDE.md when you scaffold.

| Language   | Build command           | Test command         |
| ---------- | ----------------------- | -------------------- |
| Python     | python3 -m compileall . | python3 -m unittest  |
| Rust       | cargo build             | cargo test           |
| TypeScript | npm run build           | npm test (vitest)    |
| Go         | go build ./...          | go test ./...        |
| Ruby       | (none, or a syntax check) | rake test          |

Any language works; these are the smooth defaults. Pick the one your pod is
fastest in. If your project has no build step, set Build to a quick syntax or
type check, or leave it out and let the test command be the gate.

## Part 1: build with the factory (today, two 30-minute slots)

### Slot 1: stand up your factory and ship one feature

1. Set up the starter kit on your project. Follow starter/README.md: copy it in,
   scaffold a minimal real project, set your build and test commands in
   CLAUDE.md, commit.
2. Ship your first feature through the three stations:

   ```
   /planner <your feature in one sentence>
   /refine <bean-id>
   /implement <bean-id>
   ```

3. Watch the Bean after each station, not just the chat. The Bean is the
   hand-off. After a run, open runs/trace.jsonl to see what the factory did.

Expected outcome: a Bean that carried one real feature from idea to a branch with
green tests, on a project you chose.

### Slot 2: add a second feature

Run a second feature through the same three stations. It goes faster now: the
factory is set up, and refine has real code to explore.

For Game of Life, good second features are wrap-around edges, a randomised start,
a population counter, or a named-pattern library.

Expected outcome: two Beans, two features, and a feel for how the second trip is
quicker than the first.

### Reflection (pod, 5 minutes)

- What carried over from the calculator unchanged? What did you set for your stack?
- Where did your project stress the factory in a way the calculator did not?
- Which guardrail earned its place?

## Part 2: make the factory improve (tomorrow)

Now the factory itself is the thing under test. The mechanics are in
instrument/README.md.

### Eval a metric that matters (light iterations)

A structural check, such as "does the Bean have a Refined Plan", is a warm-up.
Pick a metric your team would actually care about. The most useful one here is
acceptance-criteria coverage: does every acceptance criterion the planner wrote
have a test that exercises it?

1. Read your completed Bean and list its acceptance criteria.
2. Check each one against your tests. Score it: criteria covered over total.
3. For the subjective part, ask an independent agent, running as a subagent in
   its own context, to judge "are these acceptance criteria specific and
   measurable?" with one line of reasoning. Validate the judge on a good Bean and
   a deliberately vague one before you trust it.

Keep it light. Run the metric, find one gap, make one improvement (add the
missing test, or sharpen the plan), run it again. Two or three quick cycles, not
a test suite.

### Close one loop

1. Red-team your factory. Feed it bad input: a vague request, a Bean with no
   plan, a hallucinated file path. Watch each station and find one escape, a
   place where it continued instead of stopping.
2. Wire a guard so that escape fails loudly every time. The shipped example
   blocks implement when the Refined Plan is missing
   (instrument/guards/require-refined-plan.sh). Adapt it to the escape you found.
3. Codify the lesson. Add one line under ## Lessons in CLAUDE.md, naming the
   check and the signal it watches.

Expected outcome: one practical metric you can run on any Bean, and one escape
that can no longer recur silently.

### Reflection (pod, 5 minutes)

- Which metric would tell you your factory is getting better or worse over time?
- Prompt, rule, hook, script or human review: which did you pick for the guard,
  and why?

## Show and tell (per pod, about 5 minutes on one screen)

- The project and the two features you shipped.
- One Bean as the hand-off: High-Level Plan, then Refined Plan, then
  Implementation Log.
- The metric you chose, and what a good versus a bad Bean scored.
- The escape you found and the guard that now catches it.
- One move you will put on your team's real factory first.
