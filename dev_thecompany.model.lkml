connection: "thelook_events"
#this is version 2.0
# Changes for the demo
# include all the views
# edit on 12/16 for demo
include: "*.view"
include: "*.dashboard"

datagroup: dev_thecompany_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "2 hour"
}

# Changes in the model
week_start_day: sunday
fiscal_month_offset: 3

# additional changes for demo today
persist_with: dev_thecompany_default_datagroup

# explore: events_two {
#   from: events

#   join: users {
#     type: left_outer
#     sql_on: ${events.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }


# }

explore: events {
  fields: [ALL_FIELDS*, -users.total_orders_per_user]
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: another_user {
    type: left_outer
    from: users
    sql_on: ${events.user_id} = ${another_user.id} ;;
    relationship: many_to_one
    fields: [another_user.gender]
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

}

explore: orders {
  fields: [ALL_FIELDS*, -users.total_orders_per_user]
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: schema_migrations {}

explore: user_data {
  fields: [ALL_FIELDS*, -users.total_orders_per_user]
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  fields: [ALL_FIELDS*, -users.total_orders_per_user]
}

explore: users_nn {}
