from pathlib import Path
import pandas as pd
import numpy as np


# ============================================================
# HMRC WORKFORCE COST AUTOMATION
# AI-STYLE BUSINESS INSIGHT ENGINE
# ============================================================

PROJECT_ROOT = Path(__file__).resolve().parents[1]
OUTPUT_DIR = PROJECT_ROOT / "Output"

KPI_FILE = OUTPUT_DIR / "monthly_workforce_kpis.csv"
EXCEPTION_FILE = OUTPUT_DIR / "workforce_exceptions.csv"

INSIGHT_FILE = OUTPUT_DIR / "AI_Business_Insights.md"
INSIGHT_CSV = OUTPUT_DIR / "AI_Business_Insights.csv"


def load_data():
    """Load KPI and exception datasets."""

    if not KPI_FILE.exists():
        raise FileNotFoundError(f"KPI file not found: {KPI_FILE}")

    if not EXCEPTION_FILE.exists():
        raise FileNotFoundError(f"Exception file not found: {EXCEPTION_FILE}")

    kpi = pd.read_csv(KPI_FILE)
    exceptions = pd.read_csv(EXCEPTION_FILE)

    return kpi, exceptions


def clean_numeric_columns(df):
    """Convert analytical columns safely to numeric."""

    numeric_columns = [
        "total_workforce",
        "total_fte",
        "payroll_cost",
        "total_staffing_cost",
        "cost_per_fte",
        "fte_to_headcount_ratio",
        "workforce_change_pct",
        "fte_change_pct",
        "staffing_cost_change_pct",
        "cost_per_fte_change_pct",
    ]

    for col in numeric_columns:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors="coerce")

    return df


def latest_period(df):
    """Return latest year/month in the dataset."""

    if df.empty:
        return None

    month_order = {
        "January": 1,
        "February": 2,
        "March": 3,
        "April": 4,
        "May": 5,
        "June": 6,
        "July": 7,
        "August": 8,
        "September": 9,
        "October": 10,
        "November": 11,
        "December": 12,
    }

    temp = df.copy()
    temp["month_num"] = temp["month"].map(month_order)

    temp = temp.sort_values(["year", "month_num"])

    return temp.iloc[-1]


def pct_change(first, last):
    """Calculate percentage change safely."""

    if first == 0 or pd.isna(first) or pd.isna(last):
        return np.nan

    return ((last - first) / first) * 100


def generate_insights(kpi, exceptions):
    """Generate business-oriented insights."""

    insights = []

    kpi = clean_numeric_columns(kpi.copy())

    latest = latest_period(kpi)

    # --------------------------------------------------------
    # Overall workforce trend
    # --------------------------------------------------------

    if len(kpi) >= 2:

        first_workforce = kpi["total_workforce"].iloc[0]
        last_workforce = kpi["total_workforce"].iloc[-1]

        workforce_change = pct_change(
            first_workforce,
            last_workforce
        )

        if not pd.isna(workforce_change):

            if workforce_change > 2:
                insights.append({
                    "category": "Workforce",
                    "signal": f"Workforce increased by {workforce_change:.2f}%.",
                    "impact": "Growth in staffing demand",
                    "recommendation":
                        "Review hiring plans, workforce utilisation and capacity requirements."
                })

            elif workforce_change < -2:
                insights.append({
                    "category": "Workforce",
                    "signal": f"Workforce decreased by {abs(workforce_change):.2f}%.",
                    "impact": "Potential workforce contraction",
                    "recommendation":
                        "Review attrition, vacancies, restructuring and operational capacity."
                })

            else:
                insights.append({
                    "category": "Workforce",
                    "signal":
                        f"Workforce remained broadly stable with a {workforce_change:.2f}% change.",
                    "impact": "Stable workforce",
                    "recommendation":
                        "Focus on productivity, workforce mix and cost efficiency."
                })

    # --------------------------------------------------------
    # Staffing cost trend
    # --------------------------------------------------------

    if len(kpi) >= 2:

        first_cost = kpi["total_staffing_cost"].iloc[0]
        last_cost = kpi["total_staffing_cost"].iloc[-1]

        cost_change = pct_change(first_cost, last_cost)

        if not pd.isna(cost_change):

            if cost_change > 5:
                insights.append({
                    "category": "Staffing Cost",
                    "signal": f"Staffing cost increased by {cost_change:.2f}%.",
                    "impact": "Potential cost pressure",
                    "recommendation":
                        "Investigate overtime, allowances, contractor mix and compensation changes."
                })

            elif cost_change < -5:
                insights.append({
                    "category": "Staffing Cost",
                    "signal": f"Staffing cost decreased by {abs(cost_change):.2f}%.",
                    "impact": "Cost reduction achieved",
                    "recommendation":
                        "Identify the drivers of the reduction and assess whether savings are sustainable."
                })

    # --------------------------------------------------------
    # Cost per FTE
    # --------------------------------------------------------

    if len(kpi) >= 2:

        first_cpf = kpi["cost_per_fte"].iloc[0]
        last_cpf = kpi["cost_per_fte"].iloc[-1]

        cpf_change = pct_change(first_cpf, last_cpf)

        if not pd.isna(cpf_change):

            if cpf_change > 3:
                insights.append({
                    "category": "Cost Efficiency",
                    "signal":
                        f"Cost per FTE increased by {cpf_change:.2f}%.",
                    "impact": "Reduced cost efficiency",
                    "recommendation":
                        "Investigate pay mix, overtime, allowances and changes in workforce composition."
                })

            elif cpf_change < -3:
                insights.append({
                    "category": "Cost Efficiency",
                    "signal":
                        f"Cost per FTE decreased by {abs(cpf_change):.2f}%.",
                    "impact": "Improved cost efficiency",
                    "recommendation":
                        "Analyse the cost drivers supporting the improvement and consider replicating them."
                })

    # --------------------------------------------------------
    # Exception analysis
    # --------------------------------------------------------

    exception_count = len(exceptions)

    insights.append({
        "category": "Exception Monitoring",
        "signal": f"{exception_count} exception records were identified.",
        "impact": "Management attention required",
        "recommendation":
            "Review exception months and investigate the underlying workforce and cost drivers."
    })

    # --------------------------------------------------------
    # Latest period
    # --------------------------------------------------------

    if latest is not None:

        insights.append({
            "category": "Latest Period",
            "signal":
                f"Latest reporting period is {latest['month']} {int(latest['year'])}.",
            "impact":
                f"Workforce {latest['total_workforce']:,.0f}; "
                f"FTE {latest['total_fte']:,.0f}.",
            "recommendation":
                "Use the latest period as the current baseline for management monitoring."
        })

    # --------------------------------------------------------
    # Exception-specific recommendations
    # --------------------------------------------------------

    if not exceptions.empty:

        if "workforce_change_pct" in exceptions.columns:

            exceptions["workforce_change_pct"] = pd.to_numeric(
                exceptions["workforce_change_pct"],
                errors="coerce"
            )

        if "staffing_cost_change_pct" in exceptions.columns:

            exceptions["staffing_cost_change_pct"] = pd.to_numeric(
                exceptions["staffing_cost_change_pct"],
                errors="coerce"
            )

        if "cost_per_fte_change_pct" in exceptions.columns:

            exceptions["cost_per_fte_change_pct"] = pd.to_numeric(
                exceptions["cost_per_fte_change_pct"],
                errors="coerce"
            )

    return insights


def save_outputs(insights):
    """Save insight results as CSV and Markdown."""

    insight_df = pd.DataFrame(insights)

    insight_df.to_csv(
        INSIGHT_CSV,
        index=False
    )

    lines = []

    lines.append("# HMRC Workforce Cost Automation")
    lines.append("")
    lines.append("## AI Business Insights")
    lines.append("")

    lines.append(
        "This report converts workforce and staffing-cost signals "
        "into business-oriented management observations and recommended actions."
    )

    lines.append("")

    lines.append("## Management Insights")
    lines.append("")

    for idx, insight in enumerate(insights, start=1):

        lines.append(
            f"### {idx}. {insight['category']}"
        )

        lines.append("")

        lines.append(
            f"**Signal:** {insight['signal']}"
        )

        lines.append(
            f"**Business Impact:** {insight['impact']}"
        )

        lines.append(
            f"**Recommended Action:** {insight['recommendation']}"
        )

        lines.append("")

    lines.append("---")
    lines.append("")
    lines.append(
        "Generated automatically from the HMRC workforce KPI and exception datasets."
    )

    INSIGHT_FILE.write_text(
        "\n".join(lines),
        encoding="utf-8"
    )


def main():
    print("=" * 60)
    print("HMRC AI BUSINESS INSIGHT AUTOMATION")
    print("=" * 60)

    try:

        kpi, exceptions = load_data()

        print(f"KPI rows loaded: {len(kpi)}")
        print(f"Exception rows loaded: {len(exceptions)}")

        insights = generate_insights(
            kpi,
            exceptions
        )

        save_outputs(insights)

        print()
        print("Business insights generated successfully.")
        print()
        print(f"Markdown report: {INSIGHT_FILE}")
        print(f"CSV report:      {INSIGHT_CSV}")
        print()
        print("Insight count:", len(insights))

    except Exception as exc:

        print()
        print("ERROR:", exc)
        raise


if __name__ == "__main__":
    main()