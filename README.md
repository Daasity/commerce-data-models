<p align="center">
    <a alt="License"
        href="https://github.com/fivetran/dbt_github/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
</p>

# Commerce Data Models
# 📣 What is the purpose of this Commerce Data Model?
The Unified Order Schema (UOS) is a data model initially designed by the Daasity(http://www.daasity.com) team that helps accelerate development of analytical capability by normalizing all commerce data: eCommerce, Marketplace, Retail and Wholesale. The normalized schema was designed to support complex fulfillment logic like split shipments and multiple delivery groups and be extensible for edge cases like product customization or personalization.
UOS is split into core tables, required to support an order across multiple commerce channels, and secondary tables that are required to provide functionality to the business. Core tables are built off the concepts of Customer, Product, Order, Fulfillment and Location which all required components of a consumer product purchase.
For product, Brands will use different naming conventions for their merchandising hierarchy from Class, Category, Sub-Category to Style or Product (which can have different meaning) and Item or SKU. This Commerce schema limits tables to Product (want some might call a Style) and Product Variant (what some might call an Item or SKU)

# Entity Relationship Diagram (ERD)
View the ERD(https://lucid.app/documents/embedded/c8da9f0c-8b3a-417c-b126-f1693f699857) in Lucidchart for the Unified Order Schema (UOS) integration illustrating the different tables and keys to join across tables.


# Unified Order Schema (UOS)
This section provides a detailed description of the Unified Order Schema (UOS) and defines each table and column in this schema.

## Overview
The Unified Order Schema (UOS) is a core data model within the Daasity transformation module that helps accelerate development of analytical capability by normalizing all commerce data: eCommerce, Marketplace, Retail and Wholesale. The normalized schema was designed to support complex fulfillment logic like split shipments and multiple delivery groups and be extensible for edge cases like product customization or personalization.
UOS is split into what we consider core tables, required to support an order across multiple commerce channels, and secondary tables that are required to provide functionality to the business. Core tables are built off the concepts of Customer, Product, Order, Fulfillment and Location which all required components of a consumer product purchase.
For product, Brands will use different naming conventions for their merchandising hierarchy from Class, Category, Sub-Category to Style or Product (which can have different meaning) and Item or SKU. We’ve taken the Shopify approach and label tables as Product (want some might call a Style) and Product Variant (what some might call an Item or SKU)

## Entity Relationship Diagram (ERD)
[Click on this link to view](https://lucid.app/documents/embedded/c8da9f0c-8b3a-417c-b126-f1693f699857) the ERD for the Unified Order Schema (UOS) integration illustrating the different tables and keys to join across tables.

## Unified Order Schema Tables
  * [Customer Email Lookup](#customer-email-lookup)[`uos.customer_email_lkp`]
  * [Customer Household Lookup](#customer-household-lookup)[`uos.customer_hshld_lkp`]
  * [Customer Phone Lookup](#customer-phone-lookup)[`uos.customer_phone_lkp`]
  * [Customers](#customers)[`uos.customers`]
  * [Employees](#employees)[`uos.employees`]
  * [Fulfillments](#fulfillments)[`uos.fulfillments`]
  * [Inventory Levels](#inventory-levels)[`uos.inventory_levels`]
  * [Locations](#locations)[`uos.locations`]
  * [Order Discount Codes](#order-discount-codes)[`uos.order_discount_codes`]
  * [Order Household Lookup](#order-household-lookup)[`uos.order_hshld_lkp`]
  * [Order Item Fulfillments](#order-item-fulfillments)[`uos.order_item_fulfillments`]
  * [Order Line Items](#order-line-items)[`uos.order_line_items`]
  * [Order Payments](#prder-payments)[`uos.order_payments`]
  * [Order Shipping Service](#order-shipping-service)[`uos.order_shipping_service`]
  * [Orders](#orders)[`uos.orders`]
  * [Product Variants](#product-variants)[`uos.product_variants`]
  * [Products](#products)[`uos.products`]
  * [Refund Line Items](#refund-line-items)[`uos.refund_line_items`]
  * [Refunds](#refunds)[`uos.refunds`]
  * [Sales Report](#sales-report)[`uos.sales_report`]
  * [Transactions](#transactions)[`uos.transactions`]
  * [Unique Customers](#unique-customers)[`uos.unique_customers`]

>[!TIP]
> Many of the tables contain the following fields which can be used to track the data flow from the source system to the integration schema within the database and then to UOS, our normalized order schema
>__loaded_at: defines when the record was last loaded into this table
>__synced_at: defines when the record was last replicated from the source system into the integration tables
>__shop_id: defines which integration the data was replicated from (this value is from the source itself)
>__uos_integration_id: the ID of the integration within the Daasity platform
>__uos_source: the general source of the data (Shopify, Amazon, Magento, etc._)h

>[!NOTE]
> We define tables with three different types:
>Core - you need to populate this table if you want to have a well-defined order model even if the source data is not structured this way which is especially true for Amazon
>Householding - these tables are important to enable customer house-holding
>Secondary - these tables are nice to have for proper Customer/Order analytics

### Customer Email Lookup
Purpose: Enables you to lookup an email address across all integrations to identify which integrations have an email address and the name and phone number associated with the email address
Table Name: `uos.customer_email_lkp`
Table Type: Householding
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>EMAIL</td><td>Email address</td></tr>
<tr><td>FIRST_NAME</td><td>First Name</td></tr>
<tr><td>LAST_NAME</td><td>Last Name</td></tr>
<tr><td>PHONE_NUMBER</td><td>Phone Number</td></tr>
<tr><td>PLATFORM</td><td>Indicates which source platform (Amazon, Shopify, Magento, Lightspeed, etc.) the email address and associated information was sourced from</td></tr>
<tr><td>UPDATED_AT</td><td>Date the record was last updated from the integration schema</td></tr>
</table>

### Customer Household Lookup
Purpose: Enables you to see the results of customer house-holding by being able to lookup each Customer ID that has been associated with a house-holded customer
Table Name: uos.customer_hshld_lkp
Table Type: Householding
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>CUSTOMER_ID</td><td>Customer ID from the Customer and Order tables enabling a householded individual to reference back to the customer in a souce system</td></tr>
<tr><td>UNIQUE_CUSTOMER_ID</td><td>Daasity generated unique customer id representing a householded individual</td></tr>
</table>

### Customer Phone Lookup
Purpose: Enables you to lookup a phone number across all integrations to identify which integrations have a phone number and the name and email address associated with the email address
Table Name: uos.customer_phone_lkp
Table Type: Householding
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>EMAIL</td><td>Email address</td></tr>
<tr><td>FIRST_NAME</td><td>First Name</td></tr>
<tr><td>LAST_NAME</td><td>Last Name</td></tr>
<tr><td>PHONE_NUMBER</td><td>Phone Number</td></tr>
<tr><td>PLATFORM</td><td>Indicates which source platform (Amazon, Shopify, Magento, Lightspeed, etc.) the email address and associated information was sourced from</td></tr>
<tr><td>UPDATED_AT</td><td>Date the record was last updated from the integration schema</td></tr>
</table>

### Customers
Purpose: Enables you to capture the most recent customer information from the source system which may be different from the customer information at the Order level.  For some systems (ex: Amazon) the information will need to be derived from the order data.
Table Name: uos.customers
Table Type: Core
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>ADDRESS1</td><td>Address line 1</td></tr>
<tr><td>ADDRESS2</td><td>Address line 2</td></tr>
<tr><td>CITY</td><td>City</td></tr>
<tr><td>CLEAN_PHONE_NUMBER</td><td>The phone number stripped of all non-numeric characters</td></tr>
<tr><td>COMPANY</td><td>Company</td></tr>
<tr><td>COUNTRY</td><td>Country</td></tr>
<tr><td>COUNTRY_CODE</td><td>Two letter country code</td></tr>
<tr><td>CREATED_AT</td><td>Date the customer was created in the source system</td></tr>
<tr><td>CUSTOMER_ACCOUNT_STATUS</td><td>Status of the customer account that relate to the ability for a customer to access their account - usually values like active, pending, inactive</td></tr>
<tr><td>CUSTOMER_ID</td><td>Non-householded unique Daasity identifier for the customer record - comprised of the source system and customer identifier from the source system</td></tr>
<tr><td>CUSTOMER_NOTES</td><td>Notes from the source system for the customer</td></tr>
<tr><td>CUSTOMER_TAGS</td><td>Tags from the source system for the customer</td></tr>
<tr><td>DO_NOT_SHARE_FLAG</td><td>Flag indicating if the customer has requested to opt-out of data sharing such as marketing co-ops, etc.</td></tr>
<tr><td>EMAIL</td><td>Email address</td></tr>
<tr><td>FIRST_NAME</td><td>First Name</td></tr>
<tr><td>LAST_NAME</td><td>Last Name</td></tr>
<tr><td>MARKETING_OPT_OUT_FLAG</td><td>Flag indicating if the customer has requested to opt-out of marketing</td></tr>
<tr><td>PHONE_NUMBER</td><td>Phone Number</td></tr>
<tr><td>STATE</td><td>State or Province</td></tr>
<tr><td>STATE_CODE</td><td>Two letter code for the State or Province</td></tr>
<tr><td>STORE_CUSTOMER_ID</td><td>Identifier for the customer in the source system</td></tr>
<tr><td>UPDATED_AT</td><td>Date the record was last updated from the integration schema</td></tr>
<tr><td>VERIFIED_EMAIL</td><td>Flag indicating if the email address has been verified</td></tr>
<tr><td>ZIPCODE</td><td>Zip or postal code</td></tr>
</table>

### Employees
Purpose: Enables you to support retail and other sales channels where tracking an employee's interaction with sales
Table Name: uos.employees
Table Type: Core
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>EMPLOYEE_ID</td><td>Unique Daasity identifier for the employee - comprised of the source system and the employee id from the source system</td></tr>
<tr><td>FIRST_NAME</td><td>First Name</td></tr>
<tr><td>LAST_NAME</td><td>Last Name</td></tr>
<tr><td>STORE_EMPLOYEE_ID</td><td>Identifier for the employee in the source system</td></tr>
</table>

### Fulfillments
Purpose: Enables you to support split-shipment and multiple recipients within a single order by keeping shipping and tracking information with the shipment and not the order.
Table Name: uos.fulfillments
Table Type: Core
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>CONVERTED_CURRENCY</td><td>The currency of the amounts for this record</td></tr>
<tr><td>CREATED_AT</td><td>Date the fulfillment was created</td></tr>
<tr><td>CURRENCY_CONVERSION_RATE</td><td>Conversion rate used for the currency conversion for this record</td></tr>
<tr><td>DELIVERY_DATE</td><td>Date the shipment was delivered</td></tr>
<tr><td>ESTIMATED_ARRIVAL_DATE</td><td>Date the fulfillment (shipment) is expected to arrive</td></tr>
<tr><td>FULLFILLMENT_COST</td><td>Cost to fulfill this shipment</td></tr>
<tr><td>FULLFILLMENT_DATE</td><td>Date the shipment was fulfilled (ie. Picked and packed)</td></tr>
<tr><td>FULLFILLMENT_ID</td><td>Daasity ID for the fulfillment - usually comprised of the source system and fulfillment id but for some commerce system must be generated</td></tr>
<tr><td>FULLFILLMENT_LOCATION</td><td>Location where the shipment was fulfilled</td></tr>
<tr><td>FULLFILLMENT_LOCATION_ID</td><td>Location ID where the shipment was fulfilled</td></tr>
<tr><td>FULLFILLMENT_STATUS</td><td>Status of the fulfillment - usually Fulfilled, Partially Fulfilled, Unfulfilled or sometimes Null</td></tr>
<tr><td>ORDER_ID</td><td>Order related to the fulfillment</td></tr>
<tr><td>ORIGINAL_CURRENCY</td><td>The currency of the amounts in the integration schema</td></tr>
<tr><td>SHIPMENT_STATUS</td><td>Status of the shipment</td></tr>
<tr><td>SHIPPING_ADDRESS1</td><td>Shipping Address Line 1</td></tr>
<tr><td>SHIPPING_ADDRESS2</td><td>Shipping Address Line 2</td></tr>
<tr><td>SHIPPING_CITY</td><td>Shipping City</td></tr>
<tr><td>SHIPPING_COMPANY</td><td>Shipping Company</td></tr>
<tr><td>SHIPPING_COST</td><td>Cost to ship the fulfillment</td></tr>
<tr><td>SHIPPING_COUNTRY</td><td>Shipping Country</td></tr>
<tr><td>SHIPPING_COUNTRY_CODE</td><td>Two letter country code</td></tr>
<tr><td>SHIPPING_FIRST_NAME</td><td>Shipping First Name</td></tr>
<tr><td>SHIPPING_LAST_NAME</td><td>Shipping Last Name</td></tr>
<tr><td>SHIPPING_LATITUDE</td><td>Latitude of the delivery address to enable geo-mapping</td></tr>
<tr><td>SHIPPING_LONGITUDE</td><td>Longitude of the delivery address to enable geo-mapping</td></tr>
<tr><td>SHIPPING_NAME</td><td>Shipping Name</td></tr>
<tr><td>SHIPPING_PHONE_NUMBER</td><td>Shipping Phone Number</td></tr>
<tr><td>SHIPPING_PHONE_NUMBER_CLEAN</td><td>The shipping phone number stripped of all non-numeric characters</td></tr>
<tr><td>SHIPPING_STATE</td><td>Shipping State or Province</td></tr>
<tr><td>SHIPPING_STATE_CODE</td><td>Two letter code for the State or Province</td></tr>
<tr><td>SHIPPING_ZIPCODE</td><td>Shipping Zip or postal code</td></tr>
<tr><td>STORE_FULFILLMENT_ID</td><td>Identifier for the fulfillment in the source system</td></tr>
<tr><td>TRACKING_COMPANY</td><td>Name of the company used to ship/deliver the shipment</td></tr>
<tr><td>TRACKING_NUMBER</td><td>Number that can be used to track the shipment</td></tr>
<tr><td>UPDATED_AT</td><td>Date the record was last updated from the integration schema</td></tr>
</table>

### Inventory Levels
Purpose: Enables you to track inventory at the SKU, day and location level and can be used to build an inventory history table
Table Name: uos.inventory_levels
Table Type: Core
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>AVAILABLE_QUANTITY</td><td>Inventory that is available</td></tr>
<tr><td>BACK_ORDER_QUANTITY</td><td>Inventory that is back-ordered to fulfill current orders</td></tr>
<tr><td>COMMITTED_QUANTITY</td><td>Inventory that is committed to orders and unavailable for fulfillment</td></tr>
<tr><td>IN_TRANSIT_QUANTITY</td><td>Inventory that is in-transit to the fulfillment location</td></tr>
<tr><td>INVENTORY_DATE</td><td>Date of the inventory levels</td></tr>
<tr><td>INVENTORY_ITEM_ID</td><td>ID of the item from the source system</td></tr>
<tr><td>INVENTORY_LEVEL_ID</td><td>Unique ID for each record</td></tr>
<tr><td>INVENTORY_QUANTITY</td><td>Inventory quanity</td></tr>
<tr><td>LISTING_SKU</td><td>SKU that is used to list or sell the item</td></tr>
<tr><td>LOCATION_ID</td><td>ID for the location where the inventory is located</td></tr>
<tr><td>LOCATION_NAME</td><td>Name of the location where the inventory is located</td></tr>
<tr><td>ON_ORDER_QUANTITY</td><td>Inventory that is on order and expected to be delivered to the fulfillment location</td></tr>
<tr><td>SKU</td><td>SKU that is used to fulfill the item</td></tr>
<tr><td>STORE_INVENTORY_ID</td><td>ID of the inventory item in the source system</td></tr>
<tr><td>VARIANT_ID</td><td>Product variant the inventory item is associated with</td></tr>
</table>

### Locations
Purpose: Enables you to support retail because you order needs to be assigned to a retail location and also to support multiple warehouses by linking to fulfillments
Table Name: uos.locations
Table Type: Core
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>ADDRESS1</td><td>Address line 1</td></tr>
<tr><td>ADDRESS2</td><td>Address line 2</td></tr>
<tr><td>CITY</td><td>City</td></tr>
<tr><td>COUNTRY</td><td>Country</td></tr>
<tr><td>CREATED_AT</td><td>Date the location was created in the source system</td></tr>
<tr><td>DELETED_AT</td><td>Date the location was removed from the source system</td></tr>
<tr><td>LOCATION_ID</td><td>Daasity ID of the location (store or warehouse) in the source system - comprised of the source system and location id</td></tr>
<tr><td>LOCATION_NAME</td><td>Name of the location (store or warehouse)</td></tr>
<tr><td>PHONE_NUMBER</td><td>Phone Number</td></tr>
<tr><td>STATE</td><td>State or Province</td></tr>
<tr><td>STORE_LOCATION_ID</td><td>ID of the location (store or warehouse) in the source system</td></tr>
<tr><td>UPDATED_AT</td><td>Date the location information was last updated in the source system</td></tr>
<tr><td>ZIPCODE</td><td>Zip or postal code</td></tr>
</table>

### Order Discount Codes
Purpose: Enables you to support systems that allow for stackable discounts - orders where more than one discount code can be used
Table Name: uos.order_discount_codes
Table Type: Secondary
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>CONVERTED_CURRENCY</td><td>The currency of the amounts for this record</td></tr>
<tr><td>CURRENCY_CONVERSION_RATE</td><td>Conversion rate used for the currency conversion for this record</td></tr>
<tr><td>DISCOUNT_AMOUNT</td><td>Amount of the discount applied</td></tr>
<tr><td>DISCOUNT_CODE</td><td>Code that was entered for the discount</td></tr>
<tr><td>DISCOUNT_TYPE</td><td>Type of discount (could be dollar, percent, line, order, etc.)</td></tr>
<tr><td>ORDER_DISCOUNT_ID</td><td>Unique ID for the order and discount</td></tr>
<tr><td>ORDER_ID</td><td>Order related to the discount</td></tr>
<tr><td>ORIGINAL_CURRENCY</td><td>The currency of the amounts in the integration schema</td></tr>
</table>

### Order Household Lookup
Purpose: Enables you to see the results of customer house-holding by being able to lookup each order and see the customer from the order system and the house-holded customer
Table Name: uos.order_hshld_lkp
Table Type: Householding
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>CUSTOMER_ID</td><td>Daasity ID for the customer from the source system</td></tr>
<tr><td>ORDER_CODE</td><td>Customer facing code for the order</td></tr>
<tr><td>ORDER_DATE</td><td>Date of the order was placed</td></tr>
<tr><td>ORDER_ID</td><td>ID of the related Order</td></tr>
<tr><td>UNIQUE_CUSTOMER_ID</td><td>Unique Daasity identifier for the householded customer</td></tr>
</table>

### Order Item Fulfillments
Purpose: Enables an item in an order to be linked to a fulfillment.  Can be used even if multiple fulfillments are required to fulfill an order line
Table Name: uos.order_item_fulfillments
Table Type: Core
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>FULFILLMENT_ID</td><td>Daasity ID for the fulfillment - usually comprised of the source system and fulfillment id but for some commerce system must be generated/td></tr>
<tr><td>ITEM_FULFILLMENT_STATUS</td><td>Status of the fulfillment for the item - usually Fulfilled or Unfulfilled</td></tr>
<tr><td>ORDER_ITEM_FULFILLMENT_ID</td><td>Daasity ID to identify the item to be fulfilled - usually the source system and source order item fulfillment id if it exists</td></tr>
<tr><td>ORDER_LINE_ID</td><td>ID of the line item of the order the item fulfillment is related to</td></tr>
<tr><td>ORDERED_QUANTITY</td><td>Number of units that were ordered</td></tr>
<tr><td>REMAINING_TO_FULFILL</td><td>Number of units that remain to be fulfilled</td></tr>
<tr><td>SKU</td><td>SKU that is used to fulfill the item</td></tr>
<tr><td>STORE_ORDER_ITEM_FULFILLMENT_ID</td><td>The item fulfillment id from the integration schema</td></tr>
<tr><td>VARIANT_ID</td><td>ID used to relate the item to the product catalog</td></tr>
</table>

### Order Line Items
Purpose: Enables you to capture the items that are sold across multiple sales channels and easier map items across systems as you have a SKU and Listing SKU
Table Name: uos.order_line_items
Table Type: Core
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>CONVERTED_CURRENCY</td><td>The currency of the amounts for this record</td></tr>
<tr><td>CURRENCY_CONVERSION_RATE</td><td>Conversion rate used for the currency conversion for this record</td></tr>
<tr><td>DISCOUNT_AMOUNT</td><td>Amount of the discount applied at the item level</td></tr>
<tr><td>GIFT_CARD_FLAG</td><td>Flag to indicate if the item is a gift card</td></tr>
<tr><td>LISTING_SKU</td><td>SKU that is used to list or sell the item</td></tr>
<tr><td>ORDER_ID</td><td>ID used to relate the item to the order</td></tr>
<tr><td>ORDER_LINE_ID</td><td>Primary key for the order line - usually the source system and the order line id from the integration schema</td></tr>
<tr><td>ORIGINAL_CURRENCY</td><td>The currency of the amounts in the integration schema</td></tr>
<tr><td>PLATFORM_COMMISSION_FEES</td><td>Item level commission fees for order from the source system - i.e. Amazon Seller Fees at the item level</td></tr>
<tr><td>PRICE</td><td>Item level price charged for the item</td></tr>
<tr><td>PRODUCT_ID</td><td>ID used to relate the item to the product catalog at the style level</td></tr>
<tr><td>PRODUCT_NAME</td><td>Name of the product at the time of purchase</td></tr>
<tr><td>QUANTITY</td><td>Number of units purchased</td></tr>
<tr><td>REFUND_FLAG</td><td>Flag to indicate if the item was refunded</td></tr>
<tr><td>SHIPPED_ITEM_FLAG</td><td>Flag to indicate if the was has been shipped</td></tr>
<tr><td>SKU</td><td>SKU for the item that was purchased</td></tr>
<tr><td>SKU_COST</td><td>Cost of the SKU at the time the item was purchased</td></tr>
<tr><td>STORE_ORDER_LINE_ID</td><td>The ID of the order line from the integration schema</td></tr>
<tr><td>TAX_AMOUNT</td><td>Amount of the tax applied at the item level</td></tr>
<tr><td>VARIANT_ID</td><td>ID used to relate the item to the product catalog at the item level</td></tr>
<tr><td>VARIANT_NAME</td><td>Name of the item (variant) at the time of the purchase</td></tr>
<tr><td>VENDOR</td><td>Name of the vendor that the SKU was purchased from (if applicable)</td></tr>
<tr><td>WEIGHT</td><td>Weight of the SKU (per single unit)</td></tr>
</table>

### Order Payments
Purpose: Enables you to support multiple payment methods for an order and split an order into multiple payments
Table Name: uos.order_payments
Table Type: Secondary
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>ORDER_ID</td><td>ID used to relate the payment to the Order</td></tr>
<tr><td>PAYMENT_GATEWAY_NAME</td><td>Name of the payment method</td></tr>
<tr><td>PAYMENT_ID</td><td>Primary key for the order payment method
</td></tr>
</table>

### Order Shipping Service
Purpose: Enables you to support multiple shipping services for an order
Table Name: uos.order_shipping_service
Table Type: Secondary
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>CARRIER_IDENTIFIER</td><td>The carrier code for the shipping method</td></tr>
<tr><td>ORDER_ID</td><td>ID used to relate the shipping service to the Order</td></tr>
<tr><td>ORDER_SHIPPING_LINE_ID</td><td></td></tr>
<tr><td>SHIPPING_CODE</td><td>Code used in fulfillment for the shipping method</td></tr>
<tr><td>SHIPPING_DISCOUNT</td><td>Discount applied to shipping</td></tr>
<tr><td>SHIPPING_LINE_ID</td><td>Primary key for the order shipping service</td></tr>
<tr><td>SHIPPING_TITLE</td><td>Title / name of the shipping method from the source system</td></tr>
</table>

### Orders
Purpose: Enables you to normalize orders from multiple systems and has key fields that are critical for certain sales channels like location and employee.
Table Name: uos.orders
Table Type: Core
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>AMOUNT_CHARGED</td><td>The total amount the customer was charged</td></tr>
<tr><td>BILLING_ADDRESS1</td><td>Address line 1</td></tr>
<tr><td>BILLING_ADDRESS2</td><td>Address line 2</td></tr>
<tr><td>BILLING_CITY</td><td>City</td></tr>
<tr><td>BILLING_COMPANY</td><td>Company</td></tr>
<tr><td>BILLING_COUNTRY</td><td>Country</td></tr>
<tr><td>BILLING_COUNTRY_CODE</td><td>Two letter country code</td></tr>
<tr><td>BILLING_FIRST_NAME</td><td>First Name</td></tr>
<tr><td>BILLING_LAST_NAME</td><td>Last Name</td></tr>
<tr><td>BILLING_LATITUDE</td><td>Latitude of the billing address to enable geo-mapping</td></tr>
<tr><td>BILLING_LONGITUDE</td><td>Longitude of the billing address to enable geo-mapping</td></tr>
<tr><td>BILLING_NAME</td><td>Full Name</td></tr>
<tr><td>BILLING_PHONE_NUMBER</td><td>Phone Number</td></tr>
<tr><td>BILLING_PHONE_NUMBER_CLEAN</td><td>The phone number stripped of all non-numeric characters</td></tr>
<tr><td>BILLING_STATE</td><td>State or Province</td></tr>
<tr><td>BILLING_STATE_CODE</td><td>Two letter code for the State or Province</td></tr>
<tr><td>BILLING_ZIPCODE</td><td>Zip or postal code</td></tr>
<tr><td>BROWSER_IP</td><td>IP of the Browser that placed the order (if applicable)</td></tr>
<tr><td>BUSINESS_ORDER_FLAG</td><td>Flag to indicate if the order was placed by a business</td></tr>
<tr><td>CANCEL_DATE</td><td>Date the order was cancelled</td></tr>
<tr><td>CANCEL_REASON</td><td>Reason the order was cancelled</td></tr>
<tr><td>CART_DISCOUNT_AMOUNT</td><td>Total discount amount at the cart level</td></tr>
<tr><td>CART_TOKEN</td><td>Token to recreate the cart</td></tr>
<tr><td>CONVERTED_CURRENCY</td><td>The currency of the amounts for this record</td></tr>
<tr><td>CREATED_AT</td><td>Date the order was created</td></tr>
<tr><td>CURRENCY_CONVERSION_RATE</td><td>Conversion rate used for the currency conversion for this record</td></tr>
<tr><td>CUSTOMER_ID</td><td>Daasity ID for the customer</td></tr>
<tr><td>CUSTOMER_LANGUAGE</td><td>Language the customer used to place the order</td></tr>
<tr><td>EMAIL</td><td>Email address</td></tr>
<tr><td>EMPLOYEE_ID</td><td>ID used to relate to the employee if an employee was used to place the order</td></tr>
<tr><td>EXPEDITED_SHIPPING_ORDER_FLAG</td><td>Flag to indicate if the order has expedited shipping</td></tr>
<tr><td>FINANCIAL_STATUS</td><td>Financial status of the payment - usually paid, pending, voided</td></tr>
<tr><td>FULFILLMENT_STATUS</td><td>Fulfillment status of the order - usually fulfilled, partially fulfilled or blank</td></tr>
<tr><td>LOCATION_ID</td><td>ID of the location where the order was placed (if applicable)</td></tr>
<tr><td>ORDER_CODE</td><td>Customer facing code for the order</td></tr>
<tr><td>ORDER_DATE</td><td>Date the order was placed</td></tr>
<tr><td>ORDER_ID</td><td>Daasity ID for the order - usually the sourcey system and the order id from the source system</td></tr>
<tr><td>ORDER_NOTES</td><td>Notes placed on the order</td></tr>
<tr><td>ORDER_SOURCE</td><td>Identifies how the order was generated (web, manual entry, POS, etc.)</td></tr>
<tr><td>ORDER_TAGS</td><td>Tags on the order</td></tr>
<tr><td>ORIGINAL_CURRENCY</td><td>The currency of the amounts in the integration schema</td></tr>
<tr><td>PLATFORM_COMMISSION_FEES</td><td>Order level commission fees for order from the source system - i.e. Shopify fees or Amazon order level fees</td></tr>
<tr><td>PRIME_ORDER_FLAG</td><td>Flag to indicate if the order was a prime order</td></tr>
<tr><td>PRODUCT_AMOUNT</td><td>Total amount for all the items purchased in the order</td></tr>
<tr><td>REFERRING_SITE</td><td>URL that was responsible for the incoming traffic</td></tr>
<tr><td>REFUND_AMOUNT</td><td>Total refund amount</td></tr>
<tr><td>REFUND_FLAG</td><td>Flag to indicate if the order had a refund</td></tr>
<tr><td>REPLACEMENT_ORDER_FLAG</td><td>Flag to indicate if the order had a replacement</td></tr>
<tr><td>SALES_CHANNEL</td><td>Identifies where the order was generated - online, specific app connected to the store, point of sales, etc.</td></tr>
<tr><td>SHIPPING_AMOUNT</td><td>Total amount charged for shipping</td></tr>
<tr><td>STORE_ORDER_ID</td><td>ID for the order from the integration schema</td></tr>
<tr><td>TAX_AMOUNT</td><td>Total amount charged for tax</td></tr>
<tr><td>TAX_RATE</td><td>Tax rate applied to the order</td></tr>
<tr><td>TAXES_INCLUDED_FLAG</td><td>Flag to indicate if tax was included in the order (i.e. VAT)</td></tr>
<tr><td>TOTAL_WEIGHT</td><td>Total weight of the order</td></tr>
<tr><td>UPDATED_AT</td><td>Date the order was last updated in the source system</td></tr>
</table>

### Product Variants
Purpose: Enables you to separately track what your customer actually buys and want to have fulfilled across multiple systems and to better have a single view of all the different systems by including the SKU and Listing SKU.  Also contains the cost so you can quickly calculate current product Gross margin
Table Name: uos.product_variants
Table Type: Core
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>BARCODE</td><td>Alphanumeric version of barcode</td></tr>
<tr><td>CONVERTED_CURRENCY</td><td>The currency of the amounts for this record</td></tr>
<tr><td>COUNTRY_OF_ORIGIN</td><td>Country where the item originated or manufactured</td></tr>
<tr><td>CREATED_AT</td><td>Date the the item was created in the source system</td></tr>
<tr><td>CURRENCY_CONVERSION_RATE</td><td>Conversion rate used for the currency conversion for this record</td></tr>
<tr><td>IMAGE_POSITION</td><td>Position of the image for the URL that was provided</td></tr>
<tr><td>IMAGE_URL</td><td>URL of the image for the item</td></tr>
<tr><td>INVENTORY_ITEM_ID</td><td>ID to used to relate to inventory levels</td></tr>
<tr><td>INVENTORY_TRACKED_FLAG</td><td>Flag to indicate if inventory is tracked for this item</td></tr>
<tr><td>LISTING_SKU</td><td>SKU that is used to list or sell the item</td></tr>
<tr><td>ORIGINAL_CURRENCY</td><td>The currency of the amounts in the integration schema</td></tr>
<tr><td>PRICE</td><td>Price of the item</td></tr>
<tr><td>PRODUCT_ID</td><td>ID used to relate the item to the Product (parent)</td></tr>
<tr><td>REQUIRES_SHIPPING_FLAG</td><td>Flag to indicate if the product requires shipping</td></tr>
<tr><td>SKU</td><td>SKU for the item</td></tr>
<tr><td>SKU_COST</td><td>Current cost of the SKU</td></tr>
<tr><td>STORE_VARIANT_ID</td><td>Product variant id from the integration schema</td></tr>
<tr><td>UPDATED_AT</td><td>Date the item was last updated in the source system</td></tr>
<tr><td>VARIANT_ID</td><td>Daasity ID for the item - usually the source system and the product variant id</td></tr>
<tr><td>VARIANT_NAME</td><td>Current name of the item</td></tr>
<tr><td>WEIGHT</td><td>Weight (numeric) of the item</td></tr>
<tr><td>WEIGHT_UNIT</td><td>Units in which the weight is supplied</td></tr>
</table>

### Products
Purpose: Enables you to include a parent for each product variant which is important for products that have size and color
Table Name: uos.products
Table Type: Secondary
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>CREATED_AT</td><td>Date the product was created</td></tr>
<tr><td>PRODUCT_ID</td><td>Daasity ID for the product - usually the source system and the ID of the product in the source system</td></tr>
<tr><td>PRODUCT_NAME</td><td>Current name of the product</td></tr>
<tr><td>PRODUCT_TAGS</td><td>Tags on the product</td></tr>
<tr><td>PRODUCT_TYPE</td><td>Type of product</td></tr>
<tr><td>PUBLISHED_AT</td><td>Date the product was published and available purchase</td></tr>
<tr><td>PUBLISHED_SCOPE</td><td>Where the product was published (website, retail, etc.)</td></tr>
<tr><td>STORE_PRODUCT_ID</td><td>ID of the product from the integration schema</td></tr>
<tr><td>UPDATED_AT</td><td>Date the product was last updated in the source system</td></tr>
<tr><td>VENDOR_NAME</td><td>Name of the vendor that the product was purchased from (if applicable)</td></tr>
</table>

### Refund Line Items
Purpose: Enables you to track the items that were refunded and has a quantity field as a customer may not return all the units of an item purchased
Table Name: uos.refund_line_items
Table Type: Secondary
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>CREATED_AT</td><td>Date the item refund was created</td></tr>
<tr><td>ORDER_ID</td><td>ID used to relate the item refund to the order</td></tr>
<tr><td>ORDER_LINE_ID</td><td>ID used to relate the item refund to the order item</td></tr>
<tr><td>QUANTITY</td><td>Number of units refunded</td></tr>
<tr><td>REFUND_ID</td><td>ID used to relate the item refund to the refund</td></tr>
<tr><td>REFUND_LINE_AMOUNT</td><td>Amount refunded</td></tr>
<tr><td>REFUND_LINE_ITEM_ID</td><td>Daasity ID of the refund line item - usually the source system and the refund line item</td></tr>
<tr><td>REFUND_LINE_TAX_AMOUNT</td><td>Tax amount refunded</td></tr>
<tr><td>STORE_REFUND_LINE_ITEM_ID</td><td>ID of the refund line item from the source system</td></tr>
</table>

### Refunds
Purpose: Enables you to track each individual refund even when there are multiple refunds to an order
Table Name: uos.refunds
Table Type: Secondary
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>CONVERTED_CURRENCY</td><td>The currency of the amounts for this record</td></tr>
<tr><td>CREATED_AT</td><td>Date the refund was created</td></tr>
<tr><td>CURRENCY_CONVERSION_RATE</td><td>Conversion rate used for the currency conversion for this record</td></tr>
<tr><td>EMPLOYEE_ID</td><td>ID of the employee that processed the refund (if applicable)</td></tr>
<tr><td>ORDER_ID</td><td>ID used to relate the refund to the order</td></tr>
<tr><td>ORIGINAL_CURRENCY</td><td>The currency of the amounts in the integration schema</td></tr>
<tr><td>REFUND_AMOUNT</td><td>Total amount of the refund</td></tr>
<tr><td>REFUND_DATE</td><td>Date the refund was processed</td></tr>
<tr><td>REFUND_ID</td><td>Daasity ID for the refund - usually the source system and id of the refund from the source system</td></tr>
<tr><td>REFUND_SHIPPING_AMOUNT</td><td>Shipping amount refunded</td></tr>
<tr><td>REFUND_TAX_AMOUNT</td><td>Tax amount refunded</td></tr>
<tr><td>STORE_REFUND_ID</td><td>ID of the refund from the source system</td></tr>
</table>

### Sales Report
Purpose: Enables you to build a more financial / transaction based table to create data needs for an accounting team that performs analysis based on the date of the order.
The Daasity code replicates the logic in the Shopify Sales Report for all the financial calculations and Transaction Type and Transaction Details
Table Name: uos.sales_report
Table Type: Secondary
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>BUSINESS_CHANNEL</td><td>Channel (D2C, Wholesale, etc.) for the Order</td></tr>
<tr><td>BUSINESS_UNIT</td><td>Business Unit for the Order</td></tr>
<tr><td>CONVERTED_CURRENCY</td><td>The currency of the amounts for this record</td></tr>
<tr><td>CURRENCY_CONVERSION_RATE</td><td>Conversion rate used for the currency conversion for this record</td></tr>
<tr><td>CUSTOMER_ID</td><td>Daasity ID for the customer</td></tr>
<tr><td>DISCOUNT_AMOUNT</td><td>Total discount amount</td></tr>
<tr><td>EMAIL_ADDRESS</td><td>Email address</td></tr>
<tr><td>FULFILLMENT_AMOUNT</td><td>Total fulfillment amount</td></tr>
<tr><td>GIFTCARD_ONLY_ORDER</td><td>Flag to indicate if the order only contained a Gift Card</td></tr>
<tr><td>GROSS_SALES</td><td>Total Gross Sales (Shopify definition where Gross Sales = Price * Units)</td></tr>
<tr><td>LISTING_SKU</td><td>SKU that is used to list or sell the item</td></tr>
<tr><td>NET_SALES</td><td>Total Net Sales (Gross - Refunds)</td></tr>
<tr><td>ORDER_CODE</td><td>Customer facing code for the order</td></tr>
<tr><td>ORDER_DATE</td><td>Date the order was placed</td></tr>
<tr><td>ORDER_ID</td><td>Daasity ID for the order - usually the sourcey system and the order id from the source system</td></tr>
<tr><td>ORDER_LINE_ID</td><td>Primary key for the order line - usually the source system and the order line id from the integration schema</td></tr>
<tr><td>ORIGINAL_CURRENCY</td><td>The currency of the amounts in the integration schema</td></tr>
<tr><td>PRICE</td><td>Price of the item</td></tr>
<tr><td>PRODUCT_NAME</td><td>Name of the product at the time of purchase</td></tr>
<tr><td>QUANTITY</td><td>Quantity purchased</td></tr>
<tr><td>REFUND_AMOUNT</td><td>Total refund amount</td></tr>
<tr><td>REFUND_DATE</td><td>Date the refund was processed</td></tr>
<tr><td>SHIPPING_AMOUNT</td><td>Total amount charged for shipping</td></tr>
<tr><td>SKU</td><td>SKU of the item at time of purchase</td></tr>
<tr><td>SKU_COST</td><td>Cost of the SKU at the time the item was purchased</td></tr>
<tr><td>STORE_COUNTRY</td><td>Country for the store (sales channel) where the order was placed</td></tr>
<tr><td>STORE_CUSTOMER_ID</td><td>ID of the customer from the source system</td></tr>
<tr><td>STORE_INTEGRATION_NAME</td><td>Name of the integration for the order from the Daasity system</td></tr>
<tr><td>STORE_NAME</td><td>Name of the store from the Daasity system</td></tr>
<tr><td>STORE_ORDER_ID</td><td>ID of the order from the source system</td></tr>
<tr><td>STORE_ORDER_LINE_ID</td><td>ID of the order line from the source system</td></tr>
<tr><td>STORE_PRODUCT_ID</td><td>ID of the product from the source system</td></tr>
<tr><td>STORE_TRANSACTION_ID</td><td>ID of the transaction from the integration schema</td></tr>
<tr><td>STORE_TYPE</td><td>Type of store (ecommerce, retail, etc.) where the order was placed</td></tr>
<tr><td>STORE_VARIANT_ID</td><td>ID of the variant from the integration schema</td></tr>
<tr><td>TAX_AMOUNT</td><td>Total amount charged for tax</td></tr>
<tr><td>TRANSACTION_DATE</td><td>Date the transaction was processed</td></tr>
<tr><td>TRANSACTION_DETAIL_TYPE</td><td>Indicates if the record associated with the order is an Order or Refund and if it is at the Order or Item level</td></tr>
<tr><td>TRANSACTION_ID</td><td>ID of the transaction from the integration schema</td></tr>
<tr><td>TRANSACTION_TYPE</td><td>Indicates if the record is an Order or Refund record</td></tr>
</table>

### Transactions
Purpose: Enables you to track each transaction associated with an order
Table Name: uos.transactions
Table Type: Secondary
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>AVS_RESULT_CODE</td><td>Result code from Address Verification (AVS) in credit card processing</td></tr>
<tr><td>CONVERTED_CURRENCY</td><td>The currency of the amounts for this record</td></tr>
<tr><td>CREATED_AT</td><td>Date the transaction was created</td></tr>
<tr><td>CREDIT_CARD_BIN</td><td>The first 6 digits of the credit card number</td></tr>
<tr><td>CREDIT_CARD_COMPANY</td><td>The type of credit card uses (Amex, Visa, Mastercard, etc.)</td></tr>
<tr><td>CURRENCY_CONVERSION_RATE</td><td>Conversion rate used for the currency conversion for this record</td></tr>
<tr><td>CVV_RESULT_CODE</td><td>Result code from Card Verification (CVV) in credit card processing</td></tr>
<tr><td>ORDER_ID</td><td>ID used to relate the transaction to the Order</td></tr>
<tr><td>ORIGINAL_CURRENCY</td><td>The currency of the amounts in the integration schema</td></tr>
<tr><td>STORE_TRANSACTION_ID</td><td>ID of the transaction from the source system</td></tr>
<tr><td>TRANSACTION_AMOUNT</td><td>Amount of the transaction</td></tr>
<tr><td>TRANSACTION_AUTHORIZATION</td><td>Authorization code for the transaction</td></tr>
<tr><td>TRANSACTION_DATE</td><td>Date the transaction was processed</td></tr>
<tr><td>TRANSACTION_GATEWAY</td><td>Gateway used to process the transaction</td></tr>
<tr><td>TRANSACTION_ID</td><td>Daasity ID for the transaction - usually the source system and transaction id</td></tr>
<tr><td>TRANSACTION_SOURCE</td><td>Application that was used to create the transaction (ex: web, app, mobile, etc.)</td></tr>
<tr><td>TRANSACTION_STATUS</td><td>Status of the transaction (ex: success, failure, error)</td></tr>
<tr><td>TRANSACTION_TYPE</td><td>Type of transaction (ex: authorization, sale, refund, etc.)</td></tr>
</table>

### Unique Customers
Purpose: Enables you to keep most recent customer information based on the results of customer householding.
Table Name: uos.unique_customers
Table Type: Householding
<table>
<thead><th width="30%">Column</th><th>Description</th></thead>
<tr><td>ADDRESS1</td><td>Most recent address for the householded customer</td></tr>
<tr><td>ADDRESS2</td><td>Most recent address for the householded customer</td></tr>
<tr><td>CITY</td><td>Most recent city for the householded customer</td></tr>
<tr><td>COMPANY</td><td>Most recent company (if applicable) for the householded customer</td></tr>
<tr><td>COUNTRY</td><td>Most recent country for the householded customer</td></tr>
<tr><td>COUNTRY_CODE</td><td>The two letter country code of the county</td></tr>
<tr><td>CREATED_AT</td><td>The date the householded customer was first created</td></tr>
<tr><td>EMAIL</td><td>Most recent email address for the householded customer</td></tr>
<tr><td>FIRST_NAME</td><td>Most recent first name for the householded customer</td></tr>
<tr><td>LAST_NAME</td><td>Most recent last name for the householded customer</td></tr>
<tr><td>PHONE_NUMBER</td><td>Most recent phone number for the householded customer</td></tr>
<tr><td>STATE</td><td>Most recent state (province) for the householded customer</td></tr>
<tr><td>STATE_CODE</td><td>The two letter state code for the state</td></tr>
<tr><td>UNIQUE_CUSTOMER_ID</td><td>Unique Daasity identifier for the householded customer</td></tr>
<tr><td>UPDATED_AT</td><td>Date the unique customer was last householded</td></tr>
<tr><td>ZIPCODE</td><td>Most recent zip (postal) code for the householded customer</td></tr>
</table>

