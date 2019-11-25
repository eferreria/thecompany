view: orders {
  sql_table_name: demo_db.orders ;;

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
      quarter,
      year,
      fiscal_quarter,
      fiscal_quarter_of_year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }

  measure: min_order_date {
    type: date_time
    label: "First Order Date"
    sql: trunc(min(${created_date})) ;;
  }

  measure: max_order_date {
    type: date_time
    label: "Last Order Date"
    sql: trunc(max(${created_date})) ;;
  }

  set: default {
    fields: [users.city, users.state, status, count]
  }
}
