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
