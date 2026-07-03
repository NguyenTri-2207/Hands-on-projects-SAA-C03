"""Calculation tools Lambda — dispatch by toolName. Implement in Phase 3."""

from decimal import Decimal


def lambda_handler(event, context):
    tool_name = event.get("toolName")
    tool_input = event.get("toolInput", {})

    handlers = {
        "calculate_financial_ratio": calculate_financial_ratio,
        "reconcile_line_items": reconcile_line_items,
        "cross_validate_periods": cross_validate_periods,
        "generate_audit_finding": generate_audit_finding,
    }

    handler = handlers.get(tool_name)
    if not handler:
        return {"error": f"Unknown tool: {tool_name}"}

    return handler(tool_input)


def _severity(discrepancy_percent: float) -> str:
    if discrepancy_percent < 1.0:
        return "minor"
    if discrepancy_percent <= 5.0:
        return "material"
    return "critical"


def calculate_financial_ratio(params: dict) -> dict:
    numerator = Decimal(str(params["numerator"]))
    denominator = Decimal(str(params["denominator"]))
    reported = Decimal(str(params["reportedValue"]))

    if denominator == 0:
        return {"passed": False, "severity": "critical", "error": "Division by zero"}

    calculated = numerator / denominator
    discrepancy = abs(calculated - reported)
    discrepancy_percent = float(discrepancy / reported * 100) if reported else 100.0
    severity = _severity(discrepancy_percent)

    return {
        "calculatedValue": float(calculated),
        "reportedValue": float(reported),
        "discrepancy": float(discrepancy),
        "discrepancyPercent": round(discrepancy_percent, 2),
        "severity": severity,
        "passed": severity == "minor",
    }


def reconcile_line_items(params: dict) -> dict:
    # TODO Phase 3: load child values from context or pass in toolInput
    parent_value = Decimal(str(params["parentValue"]))
    children_sum = Decimal(str(params.get("childrenSum", params["parentValue"])))
    discrepancy = abs(parent_value - children_sum)

    return {
        "childrenSum": float(children_sum),
        "parentValue": float(parent_value),
        "discrepancy": float(discrepancy),
        "passed": discrepancy == 0,
    }


def cross_validate_periods(params: dict) -> dict:
    current = Decimal(str(params["currentPeriodValue"]))
    prior = Decimal(str(params["priorPeriodValue"]))
    tolerance = Decimal(str(params.get("tolerancePercent", 50)))

    if prior == 0:
        change_percent = 100.0
    else:
        change_percent = float(abs((current - prior) / prior * 100))

    anomaly = change_percent > float(tolerance)

    return {
        "changePercent": round(change_percent, 2),
        "passed": not anomaly,
        "anomaly": anomaly,
        "note": f"{params['metric']} changed {change_percent:.2f}% period-over-period",
    }


def generate_audit_finding(params: dict) -> dict:
    return {
        "findingId": "F-PENDING",
        "findingType": params["findingType"],
        "severity": params["severity"],
        "description": params["description"],
        "evidence": params.get("evidence", {}),
        "recommendation": "Review source line items and verify calculations",
    }
