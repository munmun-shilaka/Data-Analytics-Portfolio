# Data Dictionary

## Listings Table

The `listings` table contains property-level information for Airbnb listings in New York City.

| Column | Description | Business Use |
|---|---|---|
| `id` | Unique listing identifier | Listing-level analysis |
| `name` | Listing/property name | Property identification |
| `host_id` | Unique host identifier | Host performance analysis |
| `host_profile_id` | Host profile reference | Host analysis |
| `host_name` | Host name | Host portfolio analysis |
| `neighbourhood_group` | NYC borough | Borough-level analysis |
| `neighbourhood` | NYC neighbourhood | Local market analysis |
| `latitude` | Listing latitude | Geographic analysis |
| `longitude` | Listing longitude | Geographic analysis |
| `room_type` | Type of accommodation | Product/room analysis |
| `price` | Listed nightly price | Pricing analysis |
| `minimum_nights` | Minimum required stay | Booking policy analysis |
| `number_of_reviews` | Total reviews received | Customer engagement |
| `last_review` | Date of latest review | Recency analysis |
| `reviews_per_month` | Average reviews per month | Demand/engagement analysis |
| `availability_365` | Number of available days in a year | Availability analysis |
| `host_listings_count` | Total listings managed by host | Host portfolio analysis |
| `calculated_host_listings_count` | Calculated host listing count | Host concentration analysis |
| `license` | Property license information | Compliance/reference |

## Reviews Table

The `reviews` table contains customer review activity.

| Column | Description | Business Use |
|---|---|---|
| `listing_id` | Listing associated with the review | Link reviews to listings |
| `date` | Review date | Review trend analysis |

## Neighbourhoods Table

The `neighbourhoods` table provides the NYC neighbourhood reference list.

| Column | Description | Business Use |
|---|---|---|
| `neighbourhood_group` | NYC borough | Geographic grouping |
| `neighbourhood` | NYC neighbourhood | Geographic reference |

## Calendar Table

The `calendar` table contains daily listing availability information.

| Column | Description | Business Use |
|---|---|---|
| `listing_id` | Listing identifier | Link availability to listings |
| `date` | Calendar date | Time-based availability analysis |
| `available` | Availability status (`t` / `f`) | Supply and availability analysis |
| `minimum_nights` | Minimum nights applicable on that date | Booking policy analysis |
| `maximum_nights` | Maximum nights applicable on that date | Booking policy analysis |

## Important Data Notes

- The public dataset does not contain actual Airbnb booking revenue.
- `price` represents the listed nightly price.
- Review counts represent customer engagement and should not be interpreted directly as booking counts.
- Availability data represents listing availability, not confirmed bookings.
- Revenue-related metrics in this project are therefore treated as pricing or estimated opportunity measures rather than actual company revenue.