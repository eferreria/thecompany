- dashboard: operational_metrics__overview
  title: Operational Metrics - Overview
  layout: newspaper
  embed_style:
    background_color: "#ffffff"
    show_title: false
    title_color: "#3a4245"
    show_filters_bar: true
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Thrive (copy)
    name: Thrive (copy)
    model: operational_metrics
    explore: operational_metrics
    type: single_value
    fields: [operational_metrics.pillar, operational_metrics.old_site_status]
    filters:
      operational_metrics.event_fiscal_year: 1 fiscal years
      operational_metrics.pillar: Equality
    sorts: [operational_metrics.old_site_status desc]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: false
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [operational_metrics.pillar]
    listen:
      Event Month: operational_metrics.event_date
    row: 5
    col: 8
    width: 7
    height: 7
  - title: Lives
    name: Lives
    model: operational_metrics
    explore: operational_metrics
    type: single_value
    fields: [operational_metrics.pillar, operational_metrics.old_site_status]
    filters:
      operational_metrics.event_fiscal_year: 1 fiscal years
      operational_metrics.pillar: Lives
    sorts: [operational_metrics.old_site_status desc]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: false
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [operational_metrics.pillar]
    listen:
      Event Month: operational_metrics.event_date
    row: 5
    col: 15
    width: 7
    height: 7
  - title: New Tile
    name: New Tile
    model: operational_metrics
    explore: operational_metrics
    type: single_value
    fields: [operational_metrics.pillar, operational_metrics.overview_header]
    filters:
      operational_metrics.event_fiscal_year: 1 fiscal years
      operational_metrics.pillar: Thrive
      operational_metrics.event_date: this month
    sorts: [operational_metrics.overview_header desc]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: false
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [operational_metrics.pillar]
    row: 2
    col: 0
    width: 24
    height: 3
  - title: Service
    name: Service
    model: operational_metrics
    explore: operational_metrics
    type: single_value
    fields: [operational_metrics.pillar, operational_metrics.pillar_status_percent]
    filters:
      operational_metrics.event_fiscal_year: 1 fiscal years
      operational_metrics.pillar: Service
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: false
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [operational_metrics.pillar]
    listen:
      Event Month: operational_metrics.event_date
    row: 12
    col: 1
    width: 7
    height: 7
  - name: ''
    type: text
    body_text: <a type="button" class="btn btn-info btn-lg btn-block" href="https://bethematchstaging.looker.com/embed/dashboards/5">Overview</a>
    row: 0
    col: 0
    width: 4
    height: 2
  - name: '1a'
    type: text
    body_text: |-
      <a type="button" class="btn btn-secondary btn-lg btn-block" href="https://bethematchstaging.looker.com/embed/dashboards/16"
      color="#0079c1"><font color="#0079c1">Thrive</font></a>
    row: 0
    col: 4
    width: 4
    height: 2
  - name: '1b'
    type: text
    body_text: <a type="button" class="btn btn-secondary btn-lg btn-block" href="https://bethematchstaging.looker.com/embed/dashboards/5"><font
      color="#0079c1">Lives</font></a>
    row: 0
    col: 12
    width: 4
    height: 2
  - name: '1c'
    type: text
    body_text: <a type="button" class="btn btn-secondary btn-lg btn-block" href="https://bethematchstaging.looker.com/embed/dashboards/5"><font
      color="#0079c1">Service</font></a>
    row: 0
    col: 16
    width: 4
    height: 2
  - name: '1d'
    type: text
    body_text: <a type="button" class="btn btn-secondary btn-lg btn-block" href="https://bethematchstaging.looker.com/embed/dashboards/5"><font
      color="#0079c1">Stewardship</font></a>
    row: 0
    col: 20
    width: 4
    height: 2
  - title: Thrive
    name: Thrive
    model: operational_metrics
    explore: operational_metrics
    type: single_value
    fields: [operational_metrics.pillar, operational_metrics.old_site_status]
    filters:
      operational_metrics.event_fiscal_year: 1 fiscal years
      operational_metrics.pillar: Thrive
    sorts: [operational_metrics.old_site_status desc]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: false
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [operational_metrics.pillar]
    note_state: expanded
    note_display: below
    note_text: ''
    listen:
      Event Month: operational_metrics.event_date
    row: 5
    col: 1
    width: 7
    height: 7
  - title: Stewardship
    name: Stewardship
    model: operational_metrics
    explore: operational_metrics
    type: single_value
    fields: [operational_metrics.pillar, operational_metrics.crushed, operational_metrics.improved,
      operational_metrics.ytd_status, operational_metrics.steward_progress, operational_metrics.metric_year_actual_percent,
      operational_metrics.metric_year_goal_percent, operational_metrics.stewardship_bar_mark]
    filters:
      operational_metrics.event_fiscal_year: 1 fiscal years
      operational_metrics.pillar: Stewardship
    sorts: [operational_metrics.steward_progress desc]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: false
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [operational_metrics.pillar, operational_metrics.ytd_status, operational_metrics.improved,
      operational_metrics.crushed]
    listen:
      Event Month: operational_metrics.event_date
    row: 12
    col: 8
    width: 14
    height: 7
  - name: '1e'
    type: text
    body_text: <a type="button" class="btn btn-secondary btn-lg btn-block" href="https://bethematchstaging.looker.com/embed/dashboards/23"><font
      color="#0079c1">Equality</font></a>
    row: 0
    col: 8
    width: 4
    height: 2
  # filters:
  # - name: Event Month
  #   title: Event Month
  #   type: field_filter
  #   default_value: this month
  #   allow_multiple_values: true
  #   required: false
  #   model: operational_metrics
  #   explore: operational_metrics
  #   listens_to_filters: []
  #   field: operational_metrics.event_date
