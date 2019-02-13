explore: parameterized_periods {}

view: parameterized_periods {
  sql_table_name: order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      day_of_month,
      day_of_week,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    hidden: yes
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: is_cancelled_or_returned {
    type: yesno
    sql:  ${status} in ('Cancelled', 'Returned');;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    label: "Total Order Items Count"
    type: count
    drill_fields: [detail*]
  }

  measure: ct_order_items_completed {
    label: "Total Order Items Count excl Cancelled and Returned"
    type: count
    filters: {
      field: is_cancelled_or_returned
      value: "No"
    }
    drill_fields: [detail*]
  }

# MCS - Total Sale Price
  measure: total_sales {
    label: "Total Sale Price"
    description: "Total sales from items sold"
    type: sum
    sql: ${sale_price} ;;
    value_format: "$ #,##0.00"
    drill_fields: [detail*]
  }

  measure: total_gross_revenue {
    description: "Titak revenue from completed sales (cancelled and returned orders excluded)"
    type: sum
    sql: ${sale_price} ;;
    drill_fields: [detail*]
    value_format: "$ #,##0.00"
    filters: {
      field: is_cancelled_or_returned
      value: "No"
    }
  }

  measure:  avg_sales{
    label: "Average Sale Price"
    description: "Average sale price of items sold"
    type: average
    sql: ${sale_price} ;;
    value_format: "$ #,##0.00"
    drill_fields: [detail*]
  }

  measure: items_returned {
    label: "Number of Items Returned"
    description: "Number of items that were returned bny dissatisfied customers"
    type: count
    drill_fields: [detail*]
    filters: {
      field: status
      value: "Returned"
    }
  }

  measure: item_return_rate {
    label: "Item Return Rate %"
    description: "Number of Items Returned / total number of items sold"
    type: number
    sql: ${items_returned}/${count} ;;
    value_format_name: percent_2
    drill_fields: [detail*]
  }

  measure: cust_returning_items {
    label: "Number of Customers Returning Items"
    description: "Number of users who have returned an item at some point"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [detail*]
    filters: {
      field: status
      value: "Returned"
    }
  }

  measure: total_customers {
    label: "Total Customers"
    description: "Number of customers with orders placed."
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [detail*]
  }

  measure: users_with_returns_pct {
    label: "% of Users with Returns"
    description: "Number of customer returning items/total number of customers"
    type: number
    sql: 1.0*${cust_returning_items}/nullif(${total_customers},0) ;;
    value_format_name: percent_2
    drill_fields: [detail*]
  }

  measure: avg_spend_per_cust {
    label: "Average Spend per Customer"
    description: "Total Sale Price / total number of customers"
    type: number
    sql: ${total_sales}/${total_customers} ;;
    value_format: "$ #,##0.00"
    drill_fields: [detail*]
  }

  measure: total_orders {
    label: "Total Orders"
    type: count_distinct
    sql: ${order_id} ;;
    drill_fields: [detail*]
  }

  measure: min_order_date {
    type: date_time
    label: "First Order Date"
    sql: trunc(min(${created_date})) ;;
    drill_fields: [detail*]
  }

  measure: max_order_date {
    type: date_time
    label: "Last Order Date"
    sql: trunc(max(${created_date})) ;;
    drill_fields: [detail*]
  }


  filter: choose_period_range {
    type: date
  }

  parameter: choose_period {
    type: number
    allowed_value: { label: "Choose period range vs period prior" value:"0" }
    allowed_value: { label: "Choose period range vs same period last year" value:"1" }
    allowed_value: { label: "Today vs Same Day Last Week" value:"2"}
    allowed_value: { label: "Yesterday vs Same Day Last Week" value:"3"}
    allowed_value: { label: "Month to date vs Last Month to date" value: "4"}
    allowed_value: { label: "Month to date vs Same Month to date Last Year" value: "5"}
    allowed_value: { label: "Last Month vs Month Prior" value: "6"}
    allowed_value: { label: "Last Month vs Same Month Last Year" value: "7"}
    allowed_value: { label: "Year to Date vs Last Year to Same Day" value: "8"}
    allowed_value: { label: "Last Weekend vs Weekend Prior" value:"9"}
  }

#   dimension: period_comparison {
#     type: string
#     sql:
#       {% if choose_period._parameter_value == "0" %}
#       -- Choose period range vs period prior
#       CASE
#         WHEN {% date_start choose_period_range %} is not null AND {% date_end choose_period_range %} is not null /* date ranges or in the past x days */
#           THEN
#             CASE
#               WHEN ${close_date} >= date({% date_start choose_period_range %})
#                 AND ${close_date} <= date({% date_end choose_period_range %})
#                 THEN 'Current Period'
#               WHEN ${close_date} >= DATE_ADD(DATE_ADD(DATE({% date_start choose_period_range %}), INTERVAL -1 DAY ),INTERVAL
#               -1*DATE_DIFF(DATE({% date_end choose_period_range %}), DATE({% date_start choose_period_range %}),day ) day)
#                 AND ${close_date} <= DATE_ADD(DATE({% date_start choose_period_range %}), INTERVAL -1 DAY )
#                 THEN 'Previous Period'
#             END
#       END
#       {% elsif choose_period._parameter_value == "1" %}
#       -- Choose period range vs last year
#       CASE
#         WHEN {% date_start choose_period_range %} is not null AND {% date_end choose_period_range %} is not null /* date ranges or in the past x days */
#           THEN
#             CASE
#               WHEN ${close_date} >= date({% date_start choose_period_range %})
#                 AND ${close_date} <= date({% date_end choose_period_range %})
#                 THEN 'Current Period'
#               WHEN ${close_date} >= date_sub(date({% date_start choose_period_range %}), INTERVAL 1 YEAR)
#                 AND ${close_date} <= date_sub(date({% date_end choose_period_range %}), INTERVAL 1 YEAR)
#                 THEN 'Previous Period'
#             END
#       END
#       {% elsif choose_period._parameter_value == "2" %}
#       -- Today vs Same Day Last Week
#       case
#         when ${close_date} >= current_date('-08:00') then 'Current Period'
#         when ${close_date} >= date_sub(current_date('-08:00'), INTERVAL 7 DAY) and ${close_date} < date_sub(current_date('-08:00'), INTERVAL 6 DAY) then 'Previous Period'
#       end
#       {% elsif choose_period._parameter_value == "3" %}
#       -- Yesterday vs Same Day Last Week
#       case
#         when ${close_date} = date_sub(current_date('-08:00'), INTERVAL 1 DAY) then 'Current Period'
#         when ${close_date} >= date_sub(current_date('-08:00'), INTERVAL 8 DAY) and ${close_date} < date_sub(current_date('-08:00'), INTERVAL 7 DAY) then 'Previous Period'
#       end
#       {% elsif choose_period._parameter_value == "4" %}
#       -- MTD vs last MTD
#       case
#         when date_trunc(${close_date}, month) = date_trunc(CURRENT_DATE('-08:00'), month) then 'Current Period'
#         when date_trunc(${close_date}, month) = date_sub(date_trunc(CURRENT_DATE('-08:00'), month), INTERVAL 1 MONTH)
#           and ${close_date} <= date_sub(CURRENT_DATE('-08:00'), INTERVAL 1 month) then 'Previous Period'
#       end
#       {% elsif choose_period._parameter_value == "5" %}
#       -- MTD vs last year same month to date
#       case
#         when date_trunc(${close_date}, month) = date_trunc(CURRENT_DATE('-08:00'), month) then 'Current Period'
#         when ${close_date} >= date_sub(date_trunc(CURRENT_DATE('-08:00'), month), INTERVAL 1 year)
#           and ${close_date} <= date_sub(CURRENT_DATE('-08:00'), INTERVAL 1 year) then 'Previous Period'
#       end
#       {% elsif choose_period._parameter_value == "6" %}
#       -- last month vs month prior
#       case
#         when date_trunc(${close_date}, month) = date_sub(date_trunc(CURRENT_DATE('-08:00'), month), INTERVAL 1 MONTH) then 'Current Period'
#         when date_trunc(${close_date}, month) = date_sub(date_trunc(CURRENT_DATE('-08:00'), month), INTERVAL 2 MONTH) then 'Previous Period'
#       end
#       {% elsif choose_period._parameter_value == "7" %}
#       -- last month vs same month last year
#       case
#         when date_trunc(${close_date}, MONTH) = date_sub(date_trunc(CURRENT_DATE('-08:00'), MONTH), INTERVAL 1 MONTH) then 'Current Period'
#         when date_trunc(${close_date}, MONTH) = date_sub(date_trunc(date_sub(CURRENT_DATE('-08:00'), INTERVAL 1 MONTH), MONTH), INTERVAL 1 YEAR) then 'Previous Period'
#       end
#       {% elsif choose_period._parameter_value == "8" %}
#       -- YTD vs last YTD
#       case
#         when date_trunc(${close_date}, YEAR) = date_trunc(CURRENT_DATE('-08:00'), YEAR) then 'Current Period'
#         when ${close_date} >= date_sub(date_trunc(CURRENT_DATE('-08:00'), YEAR), INTERVAL 1 YEAR)
#           and ${close_date} <= date_sub(CURRENT_DATE('-08:00'), INTERVAL 1 YEAR) then 'Previous Period'
#       end
#       {% elsif choose_period._parameter_value == "9" %}
#       -- last weekend vs weekend prior
#       case
#         when date_trunc(current_date('-08:00'), week) = current_date('-08:00')  --if today is sunday we look at last weekend instead of the one we are in now
#           then
#             case
#               when ${close_date} = date_sub(CURRENT_DATE('-08:00'), INTERVAL 1 WEEK) --sunday of last week
#                 OR ${close_date} = date_sub(date_sub(CURRENT_DATE('-08:00'), INTERVAL 1 WEEK), INTERVAL 1 DAY) --saturday of last week
#                 OR ${close_date} = date_sub(date_sub(CURRENT_DATE('-08:00'), INTERVAL 1 WEEK), INTERVAL 2 DAY) --friday of last week
#                 then 'Current Period'
#               when ${close_date} = date_sub(CURRENT_DATE('-08:00'), INTERVAL 2 WEEK) --sunday of 2 weeks ago
#                 OR ${close_date} = date_sub(date_sub(CURRENT_DATE('-08:00'), INTERVAL 2 WEEK), INTERVAL 1 DAY) --saturday of 2 weeks ago
#                 OR ${close_date} = date_sub(date_sub(CURRENT_DATE('-08:00'), INTERVAL 2 WEEK), INTERVAL 2 DAY) --friday of 2 weeks ago
#                 then 'Previous Period'
#             end
#           else -- if today is not sunday, use this logic which shares a sunday with the current week
#             case
#               when ${close_date} = date_trunc(CURRENT_DATE('-08:00'), WEEK) --sunday of current week
#                 OR ${close_date} = date_sub(date_trunc(CURRENT_DATE('-08:00'), WEEK), INTERVAL 1 DAY) --saturday of last week
#                 OR ${close_date} = date_sub(date_trunc(CURRENT_DATE('-08:00'), WEEK), INTERVAL 2 DAY) --friday of last week
#                 then 'Current Period'
#               when ${close_date} = date_sub(date_trunc(CURRENT_DATE('-08:00'), WEEK), INTERVAL 1 WEEK) --sunday of last week
#                 OR ${close_date} = date_sub(date_sub(date_trunc(CURRENT_DATE('-08:00'), WEEK), INTERVAL 1 DAY), INTERVAL 1 WEEK) --saturday of 2 weeks ago
#                 OR ${close_date} = date_sub(date_sub(date_trunc(CURRENT_DATE('-08:00'), WEEK), INTERVAL 2 DAY), INTERVAL 1 WEEK) --friday of 2 weeks ago
#                 then 'Previous Period'
#             end
#       end
#       {% endif %}
#     ;;
#   }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }

  dimension: field_test {
    type: string
    sql: {{order_id.name}} ;;
  }

  #---- Normal dimensions and measures --- #

}
