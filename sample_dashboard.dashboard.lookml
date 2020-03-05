- dashboard: sample_dashboard
  title: Sample Dashboard
  layout: newspaper
  elements:
  - title: Order Count
    name: Order Count
    model: dev_thecompany
    explore: orders
    type: table
    fields: [orders.id, orders.status, orders.count]
    sorts: [orders.count desc]
    limit: 500
    query_timezone: America/Los_Angeles
    listen:
      Order Status: orders.status
    row: 9
    col: 0
    width: 11
    height: 8
  - title: Map
    name: Map
    model: dev_thecompany
    explore: orders
    type: looker_map
    fields: [orders.count, users.state]
    filters:
      orders.status: ''
    sorts: [orders.count desc]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    series_types: {}
    map_position: custom
    map_latitude: 40.83784003525369
    map_longitude: -89.69444274902345
    map_zoom: 5
    listen: {}
    row: 9
    col: 11
    width: 13
    height: 8
  - title: By Status and Gender
    name: By Status and Gender
    model: dev_thecompany
    explore: orders
    type: looker_bar
    fields: [users.count, users.gender, orders.status]
    pivots: [users.gender]
    filters:
      orders.status: ''
    sorts: [users.count desc 0, users.gender]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    series_types: {}
    map_position: custom
    map_latitude: 40.83784003525369
    map_longitude: -89.69444274902345
    map_zoom: 5
    listen:
      Brand: orders.created_month
    row: 0
    col: 0
    width: 11
    height: 9
  - title: Completion Timeline
    name: Completion Timeline
    model: dev_thecompany
    explore: orders
    type: looker_line
    fields: [orders.created_week, orders.count, orders.status]
    pivots: [orders.status]
    filters:
      orders.created_year: 2 years
      orders.count: NOT NULL
    sorts: [orders.created_week desc, orders.status]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types:
      complete - orders.count: area
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    listen:
      Brand: orders.created_time
    row: 0
    col: 11
    width: 10
    height: 9
  filters:
  - name: Order Status
    title: Order Status
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_thecompany
    explore: order_items
    listens_to_filters: [Brand]
    field: orders.status
  - name: Brand
    title: Brand
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_thecompany
    explore: order_items
    listens_to_filters: []
    field: products.brand
