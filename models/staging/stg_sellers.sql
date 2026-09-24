select
    seller_id,
    seller_zip_code as zip_code,
    seller_city as city,
    seller_state as state
from {{ source('silver', 'sellers') }}