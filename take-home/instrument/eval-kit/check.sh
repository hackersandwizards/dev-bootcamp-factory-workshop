#!/usr/bin/env bash
# check.sh - is this bean (the factory's output) trustworthy?
#
# Run from your project root:
#   bash eval-kit/check.sh .beans/<your-good-bean>.md     # all PASS
#   bash eval-kit/check.sh /tmp/<your-broken-bean>.md     # some FAIL
#
# Each eval is one line. A useful eval passes a good bean and fails a broken one.

BEAN="${1:?usage: check.sh <bean-file>}"
BODY="$(cat "$BEAN")"
pass() { echo "PASS  $1"; }
fail() { echo "FAIL  $1"; }

# Just the High-Level Plan section (some checks look only there).
HLP="$(awk '/^## High-Level Plan$/{f=1;next} /^## /{f=0} f' <<<"$BODY")"

# --- evals ---

# 1. Planner stayed at altitude: the High-Level Plan names no file path.
#    A leaked path shows up as a "/" between names or a code-file extension.
#    Deliberately simple - tune the extension list to your stack.
grep -qE '[A-Za-z0-9_]/[A-Za-z0-9_]|\.(ts|tsx|js|jsx|py|go|rs|java|rb|c|h|cpp|cs|php|kt|swift|scala)\b' <<<"$HLP" \
  && fail "High-Level Plan names no file path" \
  || pass "High-Level Plan names no file path"

# 2. Refine ran: the bean has a Refined Plan.
grep -qx '## Refined Plan' <<<"$BODY" \
  && pass "Refined Plan is present" \
  || fail "Refined Plan is present"

# --- your turn: add a couple, same shape. an idea to uncomment: ---

# acceptance criteria are not a placeholder like "it works":
# grep -qi 'it works' <<<"$BODY" \
#   && fail "acceptance criteria are real" \
#   || pass "acceptance criteria are real"
