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
