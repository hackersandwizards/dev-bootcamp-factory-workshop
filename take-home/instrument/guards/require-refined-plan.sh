#!/usr/bin/env bash
# require-refined-plan.sh <bean-id>
# Deterministic guard: exit non-zero unless the bean carries a ## Refined Plan.
# Wire this into the implement station's preflight so a bean can never reach
# code without a refined plan - the escape from red-team input #2.
set -euo pipefail
BEAN="${1:?usage: require-refined-plan.sh <bean-id>}"
BODY="$(beans show "$BEAN" --json | jq -r '.body')"
if [ -z "$BODY" ] || [ "$BODY" = "null" ]; then
  echo "GUARD FAIL: bean $BEAN has empty body" >&2; exit 1
fi
if grep -qx '## Refined Plan' <<<"$BODY"; then
  echo "GUARD PASS: $BEAN has a Refined Plan"
else
  echo "GUARD FAIL: $BEAN has no '## Refined Plan' - run /refine first" >&2; exit 1
fi
