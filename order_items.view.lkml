view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
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
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
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

  measure: total_orders {
    label: "Total Orders"
    type: count_distinct
    sql: ${order_id} ;;
    drill_fields: [detail*]
  }

  parameter: kpi_selector {
    type: string
    allowed_value: {
      label: "Total Cost"
      value: "Total Cost"
    }
    allowed_value: {
      label: "Total Sales"
      value: "Total Sales"
    }
  }

  measure: dynamic_total {
    # label: "{{kpi_selector._parameter_label}}"
    type: sum
    sql:
    {% if kpi_selector._parameter_value == "'Total Cost'"  %}
    ${inventory_items.cost}
    {% elsif kpi_selector._parameter_value =="'Total Sales'" %}
    ${sale_price}
    {% endif %}
    ;;
    value_format_name: usd_0
  }



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
}

view: dynamic_dates_step {
  derived_table: {
    sql:
    select * from  demo_db.orders
    where
   created_at between {% date_start custom_date %} and {% date_end custom_date %}
    ;;

  }

  filter: custom_date {
    type: date
  }

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

}

view: column_names {
  derived_table: {
    sql:
    SELECT column_name FROM information_schema.COLUMNS
WHERE table_schema = 'demo_db'
 and table_name = 'orders';;
  }

  dimension: column_name {}
}

explore: column_names {}

explore: dynamic_dates_step {}

view: dynamic_dimension {
  derived_table: {
    sql: select {{user_input_dynamic_dim._parameter_value}} as dim_1
    from ${orders.SQL_TABLE_NAME}
    where created_at between {% date_start custom_date %} and {% date_end custom_date %}
    ;;
  }

  filter: custom_date {
    type: date
  }

  parameter: user_input_dynamic_dim {
    type: unquoted
    suggest_explore: column_names
    suggest_dimension: column_names.column_name
  }

  filter: user_input_column {
    type: string
    suggest_explore: column_names
    suggest_dimension: column_names.column_name
    sql: {{value}} ;;
  }

  dimension: dynamic_dim {
    sql: ${TABLE}.dim_1  ;;
  }

}

explore: dynamic_dimension {}
