with

source as (

    select * from {{ source('supplychain', 'data_co_supply_chain_dataset') }}

),

renamed as (

    select
        `Type` as order_type,
        `Days for shipping (real)` as days_for_shipping_actual,
        `Days for shipment (scheduled)` as days_for_shipment_scheduled,
        `Benefit per order` as benefit_per_order,
        `Sales per customer` as sales_per_customer,
        `Delivery Status` as delivery_status,
        `Late_delivery_risk` as late_delivery_risk,
        `Category Id` as category_id,
        `Category Name` as category_name,
        `Customer City` as customer_city,
        `Customer Country` as customer_country,
        `Customer Fname` as customer_first_name,
        `Customer Id` as customer_id,
        `Customer Lname` as customer_last_name,
        `Customer Segment` as customer_segment,
        `Customer State` as customer_state,
        `Customer Street` as customer_street,
        `Customer Zipcode` as customer_zipcode,
        `Department Id` as department_id,
        `Department Name` as department_name,
        `Latitude` as latitude,
        `Longitude` as longitude,
        `Market` as market,
        `Order City` as order_city,
        `Order Country` as order_country,
        `Order Customer Id` as order_customer_id,
        `order date (DateOrders)` as order_date,
        `Order Id` as order_id,
        `Order Item Cardprod Id` as order_item_product_id,
        `Order Item Discount` as order_item_discount,
        `Order Item Discount Rate` as order_item_discount_rate,
        `Order Item Id` as order_item_id,
        `Order Item Product Price` as order_item_product_price,
        `Order Item Profit Ratio` as order_item_profit_ratio,
        `Order Item Quantity` as order_item_quantity,
        `Sales` as sales,
        `Order Item Total` as order_item_total,
        `Order Profit Per Order` as order_profit_per_order,
        `Order Region` as order_region,
        `Order State` as order_state,
        `Order Status` as order_status,
        `Order Zipcode` as order_zipcode,
        `Product Card Id` as product_id,
        `Product Category Id` as product_category_id,
        `Product Description` as product_description,
        `Product Name` as product_name,
        `Product Price` as product_price,
        `Product Status` as product_status,
        `shipping date (DateOrders)` as shipping_date,
        `Shipping Mode` as shipping_mode

    from source

)

select * from renamed