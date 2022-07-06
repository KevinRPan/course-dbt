{% snapshot events_snapshot %}

  {{
    config(
      target_schema='snapshots',
      strategy='check',
      unique_key='event_id',
      check_cols=['event_type'],
    )
  }}

  SELECT * FROM {{ source('src_greenery','events') }}

{% endsnapshot %}