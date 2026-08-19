# Business Report

## 1. Business Context

New York City is one of Airbnb's most important urban markets, with substantial variation in pricing, accommodation type, host concentration, and neighbourhood demand.

The purpose of this analysis is to identify market patterns that can support pricing decisions, host strategy, and neighbourhood-level business planning.

---

## 2. Key Business Questions

The analysis addresses the following questions:

1. Which borough has the largest Airbnb supply?
2. Which borough has the highest average listing price?
3. Which room types dominate the market?
4. Which neighbourhoods command premium pricing?
5. Which hosts manage the largest portfolios?
6. How does customer review activity vary across the market?
7. How does review engagement vary across price segments?
8. Where are potential pricing opportunities?
9. How does listing availability differ by borough?
10. What actions could improve market performance?

---

## 3. Market Overview

The dataset contains 30,555 Airbnb listings across five NYC boroughs.

There are 16,474 unique hosts and 223 neighbourhoods represented in the listing data.

The dataset contains 990,170 recorded reviews, providing a substantial measure of customer engagement.

---

## 4. Borough Performance

Manhattan has the largest number of listings and the highest average listing price.

| Borough | Listings | Average Price |
|---|---:|---:|
| Manhattan | 9,771 | $379.62 |
| Brooklyn | 7,263 | $213.55 |
| Queens | 3,638 | $175.16 |
| Bronx | 829 | $152.85 |
| Staten Island | 296 | $143.15 |

### Interpretation

Manhattan represents the strongest premium market, while Brooklyn provides a larger supply base at a substantially lower average price.

Queens, Bronx, and Staten Island represent lower-price markets and may provide value-oriented opportunities.

---

## 5. Room Type Analysis

| Room Type | Listings | Average Price |
|---|---:|---:|
| Entire home/apt | 11,537 | $331.43 |
| Private room | 9,588 | $194.52 |
| Hotel room | 480 | $721.58 |
| Shared room | 192 | $164.39 |

### Interpretation

Entire homes and apartments represent the largest accommodation segment.

Hotel rooms have the highest average price but represent a comparatively small part of the dataset.

---

## 6. Pricing Segmentation

| Segment | Listings | Average Price |
|---|---:|---:|
| Budget | 5,548 | $67.84 |
| Standard | 6,700 | $146.93 |
| Premium | 7,146 | $305.06 |
| Luxury | 2,403 | $1,051.14 |

### Interpretation

Premium listings form the largest price segment.

Luxury listings command substantially higher prices but represent a smaller market segment, suggesting a specialised premium market rather than the mass market.

---

## 7. Customer Engagement

The dataset contains 990,170 reviews.

There are 21,939 listings with at least one review and 8,616 listings without recorded reviews.

The average number of reviews per listing is 32.41.

### Interpretation

Customer engagement is concentrated among a subset of listings, creating an opportunity to identify characteristics associated with stronger market traction.

---

## 8. Host Strategy

The market contains a mixture of individual hosts and large professional property portfolios.

The largest host manages hundreds of listings, demonstrating a significant professional-host segment.

### Business Implication

Airbnb can segment host support based on portfolio size:

- Individual hosts
- Small portfolio operators
- Professional hosts
- Large property managers

Different host segments may require different pricing tools, support, and account-management strategies.

---

## 9. Pricing Opportunities

Potential pricing opportunities can be identified by comparing listing prices with borough and neighbourhood benchmarks.

Listings that combine relatively strong review engagement with lower-than-market pricing may represent opportunities for hosts to test higher prices.

Conversely, expensive listings with weak customer engagement may require pricing or listing-quality optimisation.

---

## 10. Availability Analysis

The calendar data provides daily availability observations.

The dataset contains more than 11 million calendar records across the available observation period.

Overall availability is approximately 51.18%.

### Business Implication

Availability can be used as a supply indicator to identify areas where inventory is more constrained or more readily available.

---

## 11. Recommendations

### Pricing Strategy

Use neighbourhood and borough-level benchmarks to support dynamic pricing decisions rather than applying the same price strategy across NYC.

### Host Segmentation

Provide differentiated tools and support for individual hosts and professional property managers.

### Premium Market Strategy

Focus premium-market offerings on high-value neighbourhoods where pricing power is strongest.

### Customer Engagement

Identify listings with strong review activity and study their pricing, room type, location, and host characteristics.

### Market Expansion

Evaluate lower-priced boroughs for value-focused accommodation strategies and targeted host acquisition.

---

## 12. Limitations

This analysis uses publicly available listing, review, neighbourhood, and calendar data.

The dataset does not provide:

- Confirmed booking counts
- Actual Airbnb revenue
- Occupancy revenue
- Guest conversion rates
- Booking cancellation information

Therefore, conclusions about revenue should be interpreted as market/pricing opportunity analysis rather than actual Airbnb financial performance.