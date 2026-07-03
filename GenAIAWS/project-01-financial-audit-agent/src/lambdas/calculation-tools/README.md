# calculation-tools

**Trigger:** Invoked by `agent-orchestrator` (not directly by Step Functions)

## Responsibility

Deterministic financial calculations — no LLM, pure Python:

| Tool name | Handler | Description |
|-----------|---------|-------------|
| `calculate_financial_ratio` | `calc_ratio()` | ROE, current ratio, debt/equity |
| `reconcile_line_items` | `reconcile()` | Sum children == parent |
| `cross_validate_periods` | `cross_validate()` | YoY/QoQ anomaly check |
| `generate_audit_finding` | `gen_finding()` | Structured finding object |

## Input

```json
{
  "toolName": "calculate_financial_ratio",
  "toolInput": {
    "ratioType": "current_ratio",
    "numerator": 800000,
    "denominator": 533333,
    "reportedValue": 1.48
  }
}
```

## Output

```json
{
  "calculatedValue": 1.5,
  "reportedValue": 1.48,
  "discrepancy": 0.02,
  "discrepancyPercent": 1.35,
  "severity": "material",
  "passed": false
}
```

## Severity thresholds

```python
SEVERITY_THRESHOLDS = {
    "minor": 0.01,      # < 1%
    "material": 0.05,   # 1–5%
    "critical": 1.0,    # > 5% or missing data
}
```

## Files

- `handler.py` — Router: dispatch by toolName
- `calculations.py` — Pure calculation functions (unit testable)
- `requirements.txt` — empty (stdlib + decimal)
