#!/usr/bin/env bash
# Executes all week notebooks in order, in place, so the data/ pipeline
# (ghg_features.csv, model comparisons, forecasts, scenarios) is regenerated
# end to end. Requires data/owid-co2-data.csv to already be present (see
# README setup step 4) and dependencies installed (requirements.txt).
set -euo pipefail

cd "$(dirname "$0")/notebook"

if [ ! -f "../data/owid-co2-data.csv" ]; then
  echo "data/owid-co2-data.csv not found — download it first (see README Setup step 4)." >&2
  exit 1
fi

NOTEBOOKS=(
  week1_eda.ipynb
  week2_features.ipynb
  week3_regression.ipynb
  week4_ets_forecasting.ipynb
  week5_scenarios.ipynb
)

for nb in "${NOTEBOOKS[@]}"; do
  echo "==> Running $nb"
  jupyter nbconvert --to notebook --execute --inplace "$nb"
done

echo "All notebooks executed successfully."
