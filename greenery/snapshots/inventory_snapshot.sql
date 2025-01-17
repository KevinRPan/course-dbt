{% snapshot inventory_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='product_id',

      strategy='check',
      check_cols=['inventory'],
    )
  }}

  SELECT * FROM {{ source('src_greenery','products') }}

{% endsnapshot %}