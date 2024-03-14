--------------------------------------------------------------------------------------------------------------
-- Copyright 2024 Daasity, Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--     http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--------------------------------------------------------------------------------------------------------------

/*************************************************************************************************************
REVISION HISTORY
**************************************************************************************************************
CODE: create_uos_tables.sql
DATE: 2024-03-02
AUTHOR: Dan LeBlanc
*************************************************************************************************************/


-- CREATAE THE SCHEMA IF IT DOES NOT EXIST
CREATE SCHEMA IF NOT EXISTS uos;


-- CUSTOMER TABLE (LIST OF ALL CUSTOMERS AND CURRENT ADDRESS)
CREATE TABLE IF NOT EXISTS uos.customers
-- REDSHIFT BEGIN
(
    customer_id                       CHAR(32) ENCODE ZSTD
  , store_customer_id                 VARCHAR(64) ENCODE ZSTD
  , email                             VARCHAR(255) ENCODE ZSTD
  , first_name                        VARCHAR(255) ENCODE ZSTD
  , last_name                         VARCHAR(255) ENCODE ZSTD
  , company                           VARCHAR(255) ENCODE ZSTD
  , address1                          VARCHAR(255) ENCODE ZSTD
  , address2                          VARCHAR(255) ENCODE ZSTD
  , city                              VARCHAR(255) ENCODE ZSTD
  , state                             VARCHAR(255) ENCODE ZSTD
  , country                           VARCHAR(255) ENCODE ZSTD
  , zipcode                           VARCHAR(64) ENCODE ZSTD
  , phone_number                      VARCHAR(64) ENCODE ZSTD
  , clean_phone_number                VARCHAR(64) ENCODE ZSTD
  , state_code                        VARCHAR(255) ENCODE ZSTD
  , country_code                      VARCHAR(64) ENCODE ZSTD
  , customer_tags                     VARCHAR(4095) ENCODE ZSTD
  , customer_notes                    VARCHAR(4095) ENCODE ZSTD
  , customer_account_status           VARCHAR(64) ENCODE ZSTD
  , verified_email                    BOOLEAN ENCODE ZSTD
  , marketing_opt_out_flag            BOOLEAN ENCODE ZSTD
  , do_not_share_flag                 BOOLEAN ENCODE ZSTD
  , created_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , updated_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (customer_id)
  , PRIMARY KEY                       (customer_id)
)
DISTSTYLE key
DISTKEY(customer_id)
SORTKEY(customer_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    customer_id                       CHAR(32)
  , store_customer_id                 VARCHAR(64)
  , email                             VARCHAR(255)
  , first_name                        VARCHAR(255)
  , last_name                         VARCHAR(255)
  , company                           VARCHAR(255)
  , address1                          VARCHAR(255)
  , address2                          VARCHAR(255)
  , city                              VARCHAR(255)
  , state                             VARCHAR(255)
  , country                           VARCHAR(255)
  , zipcode                           VARCHAR(64)
  , phone_number                      VARCHAR(64)
  , clean_phone_number                VARCHAR(64)
  , state_code                        VARCHAR(255)
  , country_code                      VARCHAR(64)
  , customer_tags                     VARCHAR(4095)
  , customer_notes                    VARCHAR(4095)
  , customer_account_status           VARCHAR(64)
  , verified_email                    BOOLEAN
  , marketing_opt_out_flag            BOOLEAN
  , do_not_share_flag                 BOOLEAN
  , created_at                        TIMESTAMP_NTZ
  , updated_at                        TIMESTAMP_NTZ
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (customer_id)
)
CLUSTER BY (customer_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    customer_id                       STRING(32)
  , store_customer_id                 STRING(64)
  , email                             STRING(255)
  , first_name                        STRING(255)
  , last_name                         STRING(255)
  , company                           STRING(255)
  , address1                          STRING(255)
  , address2                          STRING(255)
  , city                              STRING(255)
  , state                             STRING(255)
  , country                           STRING(255)
  , zipcode                           STRING(64)
  , phone_number                      STRING(64)
  , clean_phone_number                STRING(64)
  , state_code                        STRING(255)
  , country_code                      STRING(64)
  , customer_tags                     STRING(4095)
  , customer_notes                    STRING(4095)
  , customer_account_status           STRING(64)
  , verified_email                    BOOLEAN
  , marketing_opt_out_flag            BOOLEAN
  , do_not_share_flag                 BOOLEAN
  , created_at                        TIMESTAMP
  , updated_at                        TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- UNIQUE CUSTOMER TABLE (HOUSEHOLDED CUSTOMERS)
CREATE TABLE IF NOT EXISTS uos.unique_customers
-- REDSHIFT BEGIN
(
    unique_customer_id                VARCHAR(255) ENCODE ZSTD
  , email                             VARCHAR(255) ENCODE ZSTD
  , first_name                        VARCHAR(255) ENCODE ZSTD
  , last_name                         VARCHAR(255) ENCODE ZSTD
  , company                           VARCHAR(255) ENCODE ZSTD
  , address1                          VARCHAR(255) ENCODE ZSTD
  , address2                          VARCHAR(255) ENCODE ZSTD
  , city                              VARCHAR(255) ENCODE ZSTD
  , state                             VARCHAR(255) ENCODE ZSTD
  , country                           VARCHAR(255) ENCODE ZSTD
  , zipcode                           VARCHAR(64) ENCODE ZSTD
  , phone_number                      VARCHAR(64) ENCODE ZSTD
  , state_code                        VARCHAR(255) ENCODE ZSTD
  , country_code                      VARCHAR(64) ENCODE ZSTD
  , created_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , updated_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (unique_customer_id)
  , PRIMARY KEY                       (unique_customer_id)
)
DISTSTYLE key
DISTKEY(unique_customer_id)
SORTKEY(unique_customer_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    unique_customer_id                VARCHAR(255)
  , email                             VARCHAR(255)
  , first_name                        VARCHAR(255)
  , last_name                         VARCHAR(255)
  , company                           VARCHAR(255)
  , address1                          VARCHAR(255)
  , address2                          VARCHAR(255)
  , city                              VARCHAR(255)
  , state                             VARCHAR(255)
  , country                           VARCHAR(255)
  , zipcode                           VARCHAR(64)
  , phone_number                      VARCHAR(64)
  , state_code                        VARCHAR(255)
  , country_code                      VARCHAR(64)
  , created_at                        TIMESTAMP_NTZ
  , updated_at                        TIMESTAMP_NTZ
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (unique_customer_id)
)
CLUSTER BY (unique_customer_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    unique_customer_id                STRING(255)
  , email                             STRING(255)
  , first_name                        STRING(255)
  , last_name                         STRING(255)
  , company                           STRING(255)
  , address1                          STRING(255)
  , address2                          STRING(255)
  , city                              STRING(255)
  , state                             STRING(255)
  , country                           STRING(255)
  , zipcode                           STRING(64)
  , phone_number                      STRING(64)
  , state_code                        STRING(255)
  , country_code                      STRING(64)
  , created_at                        TIMESTAMP
  , updated_at                        TIMESTAMP
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- CUSTOMER HOUSEHOLDING LOOKUP TABLE (MAPS UNIQUE CUSTOMERS TO CUSTOMERS)
CREATE TABLE IF NOT EXISTS uos.customer_hshld_lkp
-- REDSHIFT BEGIN
(
    customer_id                       CHAR(32) ENCODE ZSTD
  , unique_customer_id                VARCHAR(512) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (customer_id)
  , PRIMARY KEY                       (customer_id)
)
DISTSTYLE key
DISTKEY(customer_id)
SORTKEY(customer_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    customer_id                       CHAR(32)
  , unique_customer_id                VARCHAR(512)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (customer_id)
)
CLUSTER BY (customer_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    customer_id                       STRING(32)
  , unique_customer_id                STRING(512)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- LOCATIONS TABLE (USED FOR BOTH WHERE AN ORDER WAS TAKEN BUT ALSO WHERE THE FULFILLMENT OCCURED)
CREATE TABLE IF NOT EXISTS uos.locations
-- REDSHIFT BEGIN
(
    location_id                       CHAR(32) ENCODE ZSTD
  , store_location_id                 VARCHAR(255) ENCODE ZSTD
  , location_name                     VARCHAR(255) ENCODE ZSTD
  , address1                          VARCHAR(255) ENCODE ZSTD
  , address2                          VARCHAR(255) ENCODE ZSTD
  , city                              VARCHAR(255) ENCODE ZSTD
  , state                             VARCHAR(255) ENCODE ZSTD
  , country                           VARCHAR(255) ENCODE ZSTD
  , zipcode                           VARCHAR(64) ENCODE ZSTD
  , phone_number                      VARCHAR(64) ENCODE ZSTD
  , deleted_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , created_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , updated_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (location_id)
  , PRIMARY KEY                       (location_id)
)
DISTSTYLE KEY
DISTKEY (location_id)
SORTKEY (location_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    location_id                       CHAR(32)
  , store_location_id                 VARCHAR(255)
  , location_name                     VARCHAR(255)
  , address1                          VARCHAR(255)
  , address2                          VARCHAR(255)
  , city                              VARCHAR(255)
  , state                             VARCHAR(255)
  , country                           VARCHAR(255)
  , zipcode                           VARCHAR(64)
  , phone_number                      VARCHAR(64)
  , deleted_at                        TIMESTAMP_NTZ
  , created_at                        TIMESTAMP_NTZ
  , updated_at                        TIMESTAMP_NTZ
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (location_id)
)
CLUSTER BY (location_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    location_id                       STRING(32)
  , store_location_id                 STRING(255)
  , location_name                     STRING(255)
  , address1                          STRING(255)
  , address2                          STRING(255)
  , city                              STRING(255)
  , state                             STRING(255)
  , country                           STRING(255)
  , zipcode                           STRING(64)
  , phone_number                      STRING(64)
  , deleted_at                        TIMESTAMP
  , created_at                        TIMESTAMP
  , updated_at                        TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- EMPLOYEES TABLE (USED TO IDENTIFY WHO IN A STORE WAS ASSOCIATED WITH THE SALE OR REFUND)
CREATE TABLE IF NOT EXISTS uos.employees
-- REDSHIFT BEGIN
(
    employee_id                       CHAR(32) ENCODE ZSTD
  , store_employee_id                 VARCHAR(64) ENCODE ZSTD
  , first_name                        VARCHAR(255) ENCODE ZSTD
  , last_name                         VARCHAR(255) ENCODE ZSTD
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (employee_id)
  , PRIMARY KEY                       (employee_id)
)
DISTSTYLE KEY
DISTKEY (employee_id)
SORTKEY (employee_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    employee_id                       CHAR(32)
  , store_employee_id                 VARCHAR(64)
  , first_name                        VARCHAR(255)
  , last_name                         VARCHAR(255)
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (employee_id)
)
CLUSTER BY (employee_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    employee_id                       STRING(32)
  , store_employee_id                 STRING(64)
  , first_name                        STRING(255)
  , last_name                         STRING(255)
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- ORDERS TABLES (LIST OF ALL ORDERS)
CREATE TABLE IF NOT EXISTS uos.orders
-- REDSHIFT BEGIN
(
    order_id                          CHAR(32) ENCODE ZSTD
  , store_order_id                    VARCHAR(64) ENCODE ZSTD
  , order_code                        VARCHAR(255) ENCODE ZSTD
  , order_source                      VARCHAR(255) ENCODE ZSTD
  , sales_channel                     VARCHAR(255) ENCODE ZSTD
  , cart_token                        VARCHAR(255) ENCODE ZSTD
  , email                             VARCHAR(255) ENCODE ZSTD
  , customer_id                       CHAR(32) ENCODE ZSTD
  , location_id                       CHAR(32) ENCODE ZSTD
  , employee_id                       CHAR(32) ENCODE ZSTD
  , order_date                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , cancel_date                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , financial_status                  VARCHAR(64) ENCODE ZSTD
  , fulfillment_status                VARCHAR(64) ENCODE ZSTD
  , cancel_reason                     VARCHAR(255) ENCODE ZSTD
  , original_currency                 CHAR(3) ENCODE ZSTD
  , currency_conversion_rate          DECIMAL(20,4) ENCODE AZ64
  , converted_currency                CHAR(3) ENCODE ZSTD
  , customer_language                 CHAR(3) ENCODE ZSTD
  , browser_ip                        VARCHAR(64) ENCODE ZSTD
  , referring_site                    VARCHAR(4095) ENCODE ZSTD
  , order_tags                        VARCHAR(4095) ENCODE ZSTD
  , order_notes                       VARCHAR(4095) ENCODE ZSTD
  , business_order_flag               BOOLEAN ENCODE ZSTD
  , expedited_shipping_order_flag     BOOLEAN ENCODE ZSTD
  , prime_order_flag                  BOOLEAN ENCODE ZSTD
  , replacement_order_flag            BOOLEAN ENCODE ZSTD
  , refund_flag                       BOOLEAN ENCODE ZSTD
  , taxes_included_flag               BOOLEAN ENCODE ZSTD 
  , tax_rate                          DECIMAL(20,4) ENCODE AZ64
  , product_amount                    DECIMAL(20,4) ENCODE AZ64
  , cart_discount_amount              DECIMAL(20,4) ENCODE AZ64
  , tax_amount                        DECIMAL(20,4) ENCODE AZ64
  , shipping_amount                   DECIMAL(20,4) ENCODE AZ64
  , platform_commission_fees          DECIMAL(20,4) ENCODE AZ64
  , amount_charged                    DECIMAL(20,4) ENCODE AZ64
  , refund_amount                     DECIMAL(20,4) ENCODE AZ64
  , total_weight                      DOUBLE PRECISION ENCODE ZSTD
  , billing_name                      VARCHAR(255) ENCODE ZSTD
  , billing_company                   VARCHAR(255) ENCODE ZSTD
  , billing_address1                  VARCHAR(255) ENCODE ZSTD
  , billing_address2                  VARCHAR(255) ENCODE ZSTD
  , billing_city                      VARCHAR(255) ENCODE ZSTD
  , billing_state                     VARCHAR(255) ENCODE ZSTD
  , billing_country                   VARCHAR(255) ENCODE ZSTD
  , billing_zipcode                   VARCHAR(64) ENCODE ZSTD
  , billing_phone_number              VARCHAR(64) ENCODE ZSTD
  , billing_phone_number_clean        VARCHAR(64) ENCODE ZSTD
  , billing_state_code                VARCHAR(255) ENCODE ZSTD
  , billing_country_code              VARCHAR(64) ENCODE ZSTD
  , billing_first_name                VARCHAR(255) ENCODE ZSTD
  , billing_last_name                 VARCHAR(255) ENCODE ZSTD
  , billing_latitude                  DOUBLE PRECISION ENCODE ZSTD
  , billing_longitude                 DOUBLE PRECISION ENCODE ZSTD
  , created_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , updated_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (order_id)
  , PRIMARY KEY                       (order_id)
  , FOREIGN KEY (customer_id) REFERENCES uos.customers(customer_id)
  , FOREIGN KEY (location_id) REFERENCES uos.locations(location_id)
  , FOREIGN KEY (employee_id) REFERENCES uos.employees(employee_id)
)
DISTSTYLE key
DISTKEY(order_id)
INTERLEAVED SORTKEY(order_id, order_date, customer_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    order_id                          CHAR(32)
  , store_order_id                    VARCHAR(64)
  , order_code                        VARCHAR(255)
  , order_source                      VARCHAR(255)
  , sales_channel                     VARCHAR(255)
  , cart_token                        VARCHAR(255)
  , email                             VARCHAR(255)
  , customer_id                       CHAR(32)
  , location_id                       CHAR(32)
  , employee_id                       CHAR(32)
  , order_date                        TIMESTAMP_NTZ
  , cancel_date                       TIMESTAMP_NTZ
  , financial_status                  VARCHAR(64)
  , fulfillment_status                VARCHAR(64)
  , cancel_reason                     VARCHAR(255)
  , original_currency                 CHAR(3)
  , currency_conversion_rate          DECIMAL(20,4)
  , converted_currency                CHAR(3)
  , customer_language                 CHAR(3)
  , browser_ip                        VARCHAR(64)
  , referring_site                    VARCHAR(4095)
  , order_tags                        VARCHAR(4095)
  , order_notes                       VARCHAR(4095)
  , business_order_flag               BOOLEAN
  , expedited_shipping_order_flag     BOOLEAN
  , prime_order_flag                  BOOLEAN
  , replacement_order_flag            BOOLEAN
  , refund_flag                       BOOLEAN
  , taxes_included_flag               BOOLEAN
  , tax_rate                          DECIMAL(20,4)
  , product_amount                    DECIMAL(20,4)
  , cart_discount_amount              DECIMAL(20,4)
  , tax_amount                        DECIMAL(20,4)
  , shipping_amount                   DECIMAL(20,4)
  , platform_commission_fees          DECIMAL(20,4)
  , amount_charged                    DECIMAL(20,4)
  , refund_amount                     DECIMAL(20,4)
  , total_weight                      DOUBLE PRECISION
  , billing_name                      VARCHAR(255)
  , billing_company                   VARCHAR(255)
  , billing_address1                  VARCHAR(255)
  , billing_address2                  VARCHAR(255)
  , billing_city                      VARCHAR(255)
  , billing_state                     VARCHAR(255)
  , billing_country                   VARCHAR(255)
  , billing_zipcode                   VARCHAR(64)
  , billing_phone_number              VARCHAR(64)
  , billing_phone_number_clean        VARCHAR(64)
  , billing_state_code                VARCHAR(255)
  , billing_country_code              VARCHAR(64)
  , billing_first_name                VARCHAR(255)
  , billing_last_name                 VARCHAR(255)
  , billing_latitude                  DOUBLE PRECISION
  , billing_longitude                 DOUBLE PRECISION
  , created_at                        TIMESTAMP_NTZ
  , updated_at                        TIMESTAMP_NTZ
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (order_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (customer_id) REFERENCES uos.customers(customer_id)
  , CONSTRAINT fkey_2 FOREIGN KEY (location_id) REFERENCES uos.locations(location_id)
  , CONSTRAINT fkey_3 FOREIGN KEY (employee_id) REFERENCES uos.employees(employee_id)
)
CLUSTER BY (order_id, order_date, customer_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    order_id                          STRING(32)
  , store_order_id                    STRING(64)
  , order_code                        STRING(255)
  , order_source                      STRING(255)
  , sales_channel                     STRING(255)
  , cart_token                        STRING(255)
  , email                             STRING(255)
  , customer_id                       STRING(32)
  , location_id                       STRING(32)
  , employee_id                       STRING(32)
  , order_date                        TIMESTAMP
  , cancel_date                       TIMESTAMP
  , financial_status                  STRING(64)
  , fulfillment_status                STRING(64)
  , cancel_reason                     STRING(255)
  , original_currency                 STRING(3)
  , currency_conversion_rate          BIGDECIMAL(20,4)
  , converted_currency                STRING(3)
  , customer_language                 STRING(3)
  , browser_ip                        STRING(64)
  , referring_site                    STRING(4095)
  , order_tags                        STRING(4095)
  , order_notes                       STRING(4095)
  , business_order_flag               BOOLEAN
  , expedited_shipping_order_flag     BOOLEAN
  , prime_order_flag                  BOOLEAN
  , replacement_order_flag            BOOLEAN
  , refund_flag                       BOOLEAN
  , taxes_included_flag               BOOLEAN
  , tax_rate                          BIGDECIMAL(20,4)
  , product_amount                    BIGDECIMAL(20,4)
  , cart_discount_amount              BIGDECIMAL(20,4)
  , tax_amount                        BIGDECIMAL(20,4)
  , shipping_amount                   BIGDECIMAL(20,4)
  , platform_commission_fees          BIGDECIMAL(20,4)
  , amount_charged                    BIGDECIMAL(20,4)
  , refund_amount                     BIGDECIMAL(20,4)
  , total_weight                      BIGDECIMAL
  , billing_name                      STRING(255)
  , billing_company                   STRING(255)
  , billing_address1                  STRING(255)
  , billing_address2                  STRING(255)
  , billing_city                      STRING(255)
  , billing_state                     STRING(255)
  , billing_country                   STRING(255)
  , billing_zipcode                   STRING(64)
  , billing_phone_number              STRING(64)
  , billing_phone_number_clean        STRING(64)
  , billing_state_code                STRING(255)
  , billing_country_code              STRING(64)
  , billing_first_name                STRING(255)
  , billing_last_name                 STRING(255)
  , billing_latitude                  BIGDECIMAL
  , billing_longitude                 BIGDECIMAL
  , created_at                        TIMESTAMP
  , updated_at                        TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- PRODUCTS TABLE (LIST OF ALL PRODUCTS)
CREATE TABLE IF NOT EXISTS uos.products
-- REDSHIFT BEGIN
(
    product_id                        CHAR(32) ENCODE ZSTD
  , store_product_id                  VARCHAR(64) ENCODE ZSTD
  , product_name                      VARCHAR(255) ENCODE ZSTD
  , product_type                      VARCHAR(255) ENCODE ZSTD
  , product_tags                      VARCHAR(4095) ENCODE ZSTD
  , vendor_name                       VARCHAR(255) ENCODE ZSTD
  , published_scope                   VARCHAR(64) ENCODE ZSTD
  , published_at                      TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , created_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , updated_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (product_id)
  , PRIMARY KEY                       (product_id)
)
DISTSTYLE key
DISTKEY(product_id)
SORTKEY(product_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    product_id                        CHAR(32)
  , store_product_id                  VARCHAR(64)
  , product_name                      VARCHAR(255)
  , product_type                      VARCHAR(255)
  , product_tags                      VARCHAR(4095)
  , vendor_name                       VARCHAR(255)
  , published_scope                   VARCHAR(64)
  , published_at                      TIMESTAMP_NTZ
  , created_at                        TIMESTAMP_NTZ
  , updated_at                        TIMESTAMP_NTZ
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (product_id)
)
CLUSTER BY (product_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    product_id                        STRING(32)
  , store_product_id                  STRING(64)
  , product_name                      STRING(255)
  , product_type                      STRING(255)
  , product_tags                      STRING(4095)
  , vendor_name                       STRING(255)
  , published_scope                   STRING(64)
  , published_at                      TIMESTAMP
  , created_at                        TIMESTAMP
  , updated_at                        TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- PRODUCT VARIANTS TABLE (EQUIVALENT TO SKU)
CREATE TABLE IF NOT EXISTS uos.product_variants
-- REDSHIFT BEGIN
(
    variant_id                        CHAR(32) ENCODE ZSTD
  , store_variant_id                  VARCHAR(64) ENCODE ZSTD
  , product_id                        CHAR(32) ENCODE ZSTD
  , inventory_item_id                 CHAR(32) ENCODE ZSTD
  , variant_name                      VARCHAR(255) ENCODE ZSTD
  , listing_sku                       VARCHAR(255) ENCODE ZSTD
  , sku                               VARCHAR(255) ENCODE ZSTD
  , barcode                           VARCHAR(255) ENCODE ZSTD
  , original_currency                 CHAR(3) ENCODE ZSTD
  , currency_conversion_rate          DECIMAL(20,4) ENCODE AZ64
  , converted_currency                CHAR(3) ENCODE ZSTD
  , price                             DECIMAL(20,4) ENCODE AZ64
  , sku_cost                          DECIMAL(20,4) ENCODE AZ64
  , weight                            DECIMAL(20,4) ENCODE AZ64
  , weight_unit                       VARCHAR(64) ENCODE ZSTD
  , inventory_tracked_flag            BOOLEAN ENCODE ZSTD
  , requires_shipping_flag            BOOLEAN ENCODE ZSTD
  , country_of_origin                 VARCHAR(64) ENCODE ZSTD
  , image_url                         VARCHAR(2048) ENCODE ZSTD
  , image_position                    INT ENCODE AZ64
  , created_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , updated_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (variant_id)
  , PRIMARY KEY                       (variant_id)
  , FOREIGN KEY (product_id) REFERENCES uos.products(product_id)
)
DISTSTYLE key
DISTKEY(product_id)
INTERLEAVED SORTKEY(product_id, sku, inventory_item_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    variant_id                        CHAR(32)
  , store_variant_id                  VARCHAR(64)
  , product_id                        CHAR(32)
  , inventory_item_id                 CHAR(32)
  , variant_name                      VARCHAR(255)
  , listing_sku                       VARCHAR(255)
  , sku                               VARCHAR(255)
  , barcode                           VARCHAR(255)
  , original_currency                 CHAR(3)
  , currency_conversion_rate          DECIMAL(20,4)
  , converted_currency                CHAR(3)
  , price                             DECIMAL(20,4)
  , sku_cost                          DECIMAL(20,4)
  , weight                            DECIMAL(20,4)
  , weight_unit                       VARCHAR(64)
  , inventory_tracked_flag            BOOLEAN
  , requires_shipping_flag            BOOLEAN
  , country_of_origin                 VARCHAR(64)
  , image_url                         VARCHAR(2048)
  , image_position                    INT
  , created_at                        TIMESTAMP_NTZ
  , updated_at                        TIMESTAMP_NTZ
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (variant_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (product_id) REFERENCES uos.products(product_id)
)
CLUSTER BY(product_id, sku, inventory_item_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    variant_id                        STRING(32)
  , store_variant_id                  STRING(64)
  , product_id                        STRING(32)
  , inventory_item_id                 STRING(32)
  , variant_name                      STRING(255)
  , listing_sku                       STRING(255)
  , sku                               STRING(255)
  , barcode                           STRING(255)
  , original_currency                 STRING(3)
  , currency_conversion_rate          BIGDECIMAL(20,4)
  , converted_currency                STRING(3)
  , price                             BIGDECIMAL(20,4)
  , sku_cost                          BIGDECIMAL(20,4)
  , weight                            BIGDECIMAL(20,4)
  , weight_unit                       STRING(64)
  , inventory_tracked_flag            BOOLEAN
  , requires_shipping_flag            BOOLEAN
  , country_of_origin                 STRING(64)
  , image_url                         STRING(2048)
  , image_position                    INT
  , created_at                        TIMESTAMP
  , updated_at                        TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- ORDER LINE ITEMS TABLE (ONE ROW FOR EVERY ITEM IN AN ORDER)
CREATE TABLE IF NOT EXISTS uos.order_line_items
-- REDSHIFT BEGIN
(
    order_line_id                     CHAR(32) ENCODE ZSTD
  , store_order_line_id               VARCHAR(64) ENCODE ZSTD
  , order_id                          CHAR(32) ENCODE ZSTD
  , product_id                        CHAR(32) ENCODE ZSTD
  , product_name                      VARCHAR(255) ENCODE ZSTD
  , variant_id                        CHAR(32) ENCODE ZSTD
  , variant_name                      VARCHAR(255) ENCODE ZSTD
  , listing_sku                       VARCHAR(255) ENCODE ZSTD
  , sku                               VARCHAR(255) ENCODE ZSTD
  , vendor                            VARCHAR(255) ENCODE ZSTD
  , weight                            DECIMAL(20,4) ENCODE AZ64
  , original_currency                 CHAR(3) ENCODE ZSTD
  , currency_conversion_rate          DECIMAL(20,4) ENCODE AZ64
  , converted_currency                CHAR(3) ENCODE ZSTD
  , price                             DECIMAL(20,4) ENCODE AZ64
  , sku_cost                          DECIMAL(20,4) ENCODE AZ64
  , quantity                          BIGINT ENCODE AZ64
  , discount_amount                   DECIMAL(20,4) ENCODE AZ64
  , tax_amount                        DECIMAL(20,4) ENCODE AZ64
  , platform_commission_fees          DECIMAL(20,4) ENCODE AZ64
  , gift_card_flag                    BOOLEAN ENCODE ZSTD
  , shipped_item_flag                 BOOLEAN ENCODE ZSTD
  , refund_flag                       BOOLEAN ENCODE ZSTD
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (order_line_id)
  , PRIMARY KEY                       (order_line_id)
  , FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
  , FOREIGN KEY (product_id) REFERENCES uos.products(product_id)
  , FOREIGN KEY (variant_id) REFERENCES uos.product_variants(variant_id)
)
DISTSTYLE KEY
DISTKEY(order_id)
INTERLEAVED SORTKEY(order_id, order_line_id, product_id, variant_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    order_line_id                     CHAR(32)
  , store_order_line_id               VARCHAR(64)
  , order_id                          CHAR(32)
  , product_id                        CHAR(32)
  , product_name                      VARCHAR(255)
  , variant_id                        CHAR(32)
  , variant_name                      VARCHAR(255)
  , listing_sku                       VARCHAR(255)
  , sku                               VARCHAR(255)
  , vendor                            VARCHAR(255)
  , weight                            DECIMAL(20,4)
  , original_currency                 CHAR(3)
  , currency_conversion_rate          DECIMAL(20,4)
  , converted_currency                CHAR(3)
  , price                             DECIMAL(20,4)
  , sku_cost                          DECIMAL(20,4)
  , quantity                          BIGINT
  , discount_amount                   DECIMAL(20,4)
  , tax_amount                        DECIMAL(20,4)
  , platform_commission_fees          DECIMAL(20,4)
  , gift_card_flag                    BOOLEAN
  , shipped_item_flag                 BOOLEAN
  , refund_flag                       BOOLEAN
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (order_line_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
  , CONSTRAINT fkey_2 FOREIGN KEY (product_id) REFERENCES uos.products(product_id)
  , CONSTRAINT fkey_3 FOREIGN KEY (variant_id) REFERENCES uos.product_variants(variant_id)
)
CLUSTER BY (order_id, order_line_id, product_id, variant_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    order_line_id                     STRING(32)
  , store_order_line_id               STRING(64)
  , order_id                          STRING(32)
  , product_id                        STRING(32)
  , product_name                      STRING(255)
  , variant_id                        STRING(32)
  , variant_name                      STRING(255)
  , listing_sku                       STRING(255)
  , sku                               STRING(255)
  , vendor                            STRING(255)
  , weight                            BIGDECIMAL(20,4)
  , original_currency                 STRING(3)
  , currency_conversion_rate          BIGDECIMAL(20,4)
  , converted_currency                STRING(3)
  , price                             BIGDECIMAL(20,4)
  , sku_cost                          BIGDECIMAL(20,4)
  , quantity                          BIGINT
  , discount_amount                   BIGDECIMAL(20,4)
  , tax_amount                        BIGDECIMAL(20,4)
  , platform_commission_fees          BIGDECIMAL(20,4)
  , gift_card_flag                    BOOLEAN
  , shipped_item_flag                 BOOLEAN
  , refund_flag                       BOOLEAN
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- ORDER DISCOUNT CODE TABLE (NEEDS TO ALLOW FOR CODE STACKING - I.E. MULTIPLE CODES PER ORDER)
CREATE TABLE IF NOT EXISTS uos.order_discount_codes
-- REDSHIFT BEGIN
(
    order_discount_id                 CHAR(32) ENCODE ZSTD
  , order_id                          CHAR(32) ENCODE ZSTD
  , discount_code                     VARCHAR(64) ENCODE ZSTD
  , discount_type                     VARCHAR(64) ENCODE ZSTD
  , original_currency                 CHAR(3) ENCODE ZSTD
  , currency_conversion_rate          DECIMAL(20,4) ENCODE AZ64
  , converted_currency                CHAR(3) ENCODE ZSTD
  , discount_amount                   DECIMAL(20,4) ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (order_discount_id)
  , PRIMARY KEY                       (order_discount_id)
  , FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
)
DISTSTYLE key
DISTKEY(order_id)
INTERLEAVED SORTKEY(order_id, discount_code)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    order_discount_id                 CHAR(32)
  , order_id                          CHAR(32)
  , discount_code                     VARCHAR(64)
  , discount_type                     VARCHAR(64)
  , original_currency                 CHAR(3)
  , currency_conversion_rate          DECIMAL(20,4)
  , converted_currency                CHAR(3)
  , discount_amount                   DECIMAL(20,4)
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (order_discount_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
)
CLUSTER BY(order_id, discount_code)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    order_discount_id                 STRING(32)
  , order_id                          STRING(32)
  , discount_code                     STRING(64)
  , discount_type                     STRING(64)
  , original_currency                 STRING(3)
  , currency_conversion_rate          BIGDECIMAL(20,4)
  , converted_currency                STRING(3)
  , discount_amount                   BIGDECIMAL(20,4)
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- SHIPPING SERVICE NAME TABLE (ALLOWS FOR MULTIPLE SHIPPING SERVICES PER ORDER)
CREATE TABLE IF NOT EXISTS uos.order_shipping_service
-- REDSHIFT BEGIN
(
    order_shipping_line_id            CHAR(32) ENCODE ZSTD
  , order_id                          CHAR(32) ENCODE ZSTD
  , shipping_line_id                  CHAR(32) ENCODE ZSTD
  , shipping_code                     VARCHAR(255) ENCODE ZSTD
  , shipping_title                    VARCHAR(255) ENCODE ZSTD
  , carrier_identifier                VARCHAR(255) ENCODE ZSTD
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , PRIMARY KEY                       (order_shipping_line_id)
  , FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
)
DISTSTYLE KEY
DISTKEY(order_id)
INTERLEAVED SORTKEY(order_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    order_shipping_line_id            CHAR(32)
  , order_id                          CHAR(32)
  , shipping_line_id                  CHAR(32)
  , shipping_code                     VARCHAR(255)
  , shipping_title                    VARCHAR(255)
  , carrier_identifier                VARCHAR(255)
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , UNIQUE                            (order_shipping_line_id)
  , CONSTRAINT pkey PRIMARY KEY       (order_shipping_line_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
)
CLUSTER BY(order_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    order_shipping_line_id            STRING(32)
  , order_id                          STRING(32)
  , shipping_line_id                  STRING(32)
  , shipping_code                     STRING(255)
  , shipping_title                    STRING(255)
  , carrier_identifier                STRING(255)
  , shipping_discount                 BIGDECIMAL(20,2)
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;


-- PAYMENT GATEWAY NAME TABLE (ALLOWS FOR MULTIPLE PAYMENT METHODS PER ORDER)
CREATE TABLE IF NOT EXISTS uos.order_payments
-- REDSHIFT BEGIN
(
    payment_id                        CHAR(32) ENCODE ZSTD
  , order_id                          CHAR(32) ENCODE ZSTD
  , payment_gateway_name              VARCHAR(255) ENCODE ZSTD
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , PRIMARY KEY                       (payment_id)
  , FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
)
DISTSTYLE KEY
DISTKEY(order_id)
INTERLEAVED SORTKEY(order_id, payment_gateway_name)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    payment_id                        CHAR(32)
  , order_id                          CHAR(32)
  , payment_gateway_name              VARCHAR(255)
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , UNIQUE                            (payment_id)
  , CONSTRAINT pkey PRIMARY KEY       (payment_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
)
CLUSTER BY(order_id, payment_gateway_name)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    payment_id                        STRING(32)
  , order_id                          STRING(32)
  , payment_gateway_name              STRING(255)
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- ORDER HOUSEHOLDING LOOKUP (MAPS ORDERS FROM CUSTOMER TO UNIQUE CUSTOMER ID)
CREATE TABLE IF NOT EXISTS uos.order_hshld_lkp
-- REDSHIFT BEGIN
(
    order_id                          CHAR(32) ENCODE ZSTD
  , customer_id                       CHAR(32) ENCODE ZSTD
  , unique_customer_id                VARCHAR(255) ENCODE ZSTD
  , order_code                        VARCHAR(255) ENCODE ZSTD
  , order_date                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (order_id)
  , PRIMARY KEY                       (order_id)
  , FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
  , FOREIGN KEY (customer_id) REFERENCES uos.customers(customer_id)
  , FOREIGN KEY (unique_customer_id) REFERENCES uos.unique_customers(unique_customer_id)
)
DISTSTYLE KEY
DISTKEY(order_id)
INTERLEAVED SORTKEY(order_id, unique_customer_id, customer_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    order_id                          CHAR(32)
  , customer_id                       CHAR(32)
  , unique_customer_id                VARCHAR(255)
  , order_code                        VARCHAR(255)
  , order_date                        TIMESTAMP_NTZ
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (order_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
  , CONSTRAINT fkey_2 FOREIGN KEY (customer_id) REFERENCES uos.customers(customer_id)
  , CONSTRAINT fkey_3 FOREIGN KEY (unique_customer_id) REFERENCES uos.unique_customers(unique_customer_id)
)
CLUSTER BY(order_id, unique_customer_id, customer_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    order_id                          STRING(32)
  , customer_id                       STRING(32)
  , unique_customer_id                STRING(255)
  , order_code                        STRING(255)
  , order_date                        TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- TRANSACTION TABLE (COMBINE BOTH ORDERS AND REFUNDS)
CREATE TABLE IF NOT EXISTS uos.transactions
-- REDSHIFT BEGIN
(
    transaction_id                    CHAR(32) ENCODE ZSTD
  , store_transaction_id              VARCHAR(64) ENCODE ZSTD
  , order_id                          CHAR(32) ENCODE ZSTD
  , transaction_date                  TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , transaction_gateway               VARCHAR(255) ENCODE ZSTD
  , transaction_source                VARCHAR(64) ENCODE ZSTD
  , transaction_type                  VARCHAR(64) ENCODE ZSTD
  , transaction_status                VARCHAR(64) ENCODE ZSTD
  , transaction_authorization         VARCHAR(64) ENCODE ZSTD
  , original_currency                 CHAR(3) ENCODE ZSTD
  , currency_conversion_rate          DECIMAL(20,4) ENCODE AZ64
  , converted_currency                CHAR(3) ENCODE ZSTD
  , transaction_amount                DECIMAL(20,4) ENCODE AZ64
  , avs_result_code                   VARCHAR(64) ENCODE ZSTD
  , credit_card_bin                   VARCHAR(64) ENCODE ZSTD
  , credit_card_company               VARCHAR(255) ENCODE ZSTD
  , cvv_result_code                   VARCHAR(64) ENCODE ZSTD
  , created_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (transaction_id)
  , PRIMARY KEY                       (transaction_id)
  , FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
)
DISTSTYLE KEY
DISTKEY(transaction_id)
INTERLEAVED SORTKEY(order_id, transaction_type)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    transaction_id                    CHAR(32)
  , store_transaction_id              VARCHAR(64)
  , order_id                          CHAR(32)
  , transaction_date                  TIMESTAMP_NTZ
  , transaction_gateway               VARCHAR(255)
  , transaction_source                VARCHAR(64)
  , transaction_type                  VARCHAR(64)
  , transaction_status                VARCHAR(64)
  , transaction_authorization         VARCHAR(64)
  , original_currency                 CHAR(3)
  , currency_conversion_rate          DECIMAL(20,4)
  , converted_currency                CHAR(3)
  , transaction_amount                DECIMAL(20,4)
  , avs_result_code                   VARCHAR(64)
  , credit_card_bin                   VARCHAR(64)
  , credit_card_company               VARCHAR(255)
  , cvv_result_code                   VARCHAR(64)
  , created_at                        TIMESTAMP_NTZ
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY                       (transaction_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
)
CLUSTER BY(order_id, transaction_type)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    transaction_id                    STRING(32)
  , store_transaction_id              STRING(64)
  , order_id                          STRING(32)
  , transaction_date                  TIMESTAMP
  , transaction_gateway               STRING(255)
  , transaction_source                STRING(64)
  , transaction_type                  STRING(64)
  , transaction_status                STRING(64)
  , transaction_authorization         STRING(64)
  , original_currency                 STRING(3)
  , currency_conversion_rate          BIGDECIMAL(20,4)
  , converted_currency                STRING(3)
  , transaction_amount                BIGDECIMAL(20,4)
  , avs_result_code                   STRING(64)
  , credit_card_bin                   STRING(64)
  , credit_card_company               STRING(255)
  , cvv_result_code                   STRING(64)
  , created_at                        TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;


-- REFUND TABLES (ORDER LEVEL REFUND INFO)
CREATE TABLE IF NOT EXISTS uos.refunds
-- REDSHIFT BEGIN
(
    refund_id                         CHAR(32) ENCODE ZSTD
  , store_refund_id                   VARCHAR(64) ENCODE ZSTD
  , order_id                          CHAR(32) ENCODE ZSTD
  , employee_id                       CHAR(32) ENCODE ZSTD
  , refund_date                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , original_currency                 CHAR(3) ENCODE ZSTD
  , currency_conversion_rate          DECIMAL(20,4) ENCODE AZ64
  , converted_currency                CHAR(3) ENCODE ZSTD
  , refund_amount                     DECIMAL(20,4) ENCODE AZ64
  , created_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (refund_id)
  , PRIMARY KEY                       (refund_id)
  , FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
  , FOREIGN KEY (employee_id) REFERENCES uos.employees(employee_id)
)
DISTSTYLE KEY
DISTKEY(order_id)
INTERLEAVED SORTKEY(order_id, refund_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    refund_id                         CHAR(32)
  , store_refund_id                   VARCHAR(64)
  , order_id                          CHAR(32)
  , employee_id                       CHAR(32)
  , refund_date                       TIMESTAMP_NTZ
  , original_currency                 CHAR(3)
  , currency_conversion_rate          DECIMAL(20,4)
  , converted_currency                CHAR(3)
  , refund_amount                     DECIMAL(20,4)
  , created_at                        TIMESTAMP_NTZ
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (refund_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
  , CONSTRAINT fkey_2 FOREIGN KEY (employee_id) REFERENCES uos.employees(employee_id)
)
CLUSTER BY(order_id, refund_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    refund_id                         STRING(32)
  , store_refund_id                   STRING(64)
  , order_id                          STRING(32)
  , employee_id                       STRING(32)
  , refund_date                       TIMESTAMP
  , original_currency                 STRING(3)
  , currency_conversion_rate          DECIMAL(20,4)
  , converted_currency                STRING(3)
  , refund_amount                     BIGDECIMAL(20,4)
  , created_at                        TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;


-- REFUND LINE ITEM TABLE (DEFINES WHAT SPECIFIC ITEMS ARE BEING REFUNDED)
CREATE TABLE IF NOT EXISTS uos.refund_line_items
-- REDSHIFT BEGIN
(
    refund_line_item_id               CHAR(32) ENCODE ZSTD
  , store_refund_line_item_id         VARCHAR(64) ENCODE ZSTD
  , refund_id                         CHAR(32) ENCODE ZSTD
  , order_id                          CHAR(32) ENCODE ZSTD
  , order_line_id                     CHAR(32) ENCODE ZSTD
  , quantity                          BIGINT ENCODE AZ64
  , refund_line_amount                DECIMAL(20,4) ENCODE AZ64
  , refund_line_tax_amount            DECIMAL(20,4) ENCODE AZ64
  , created_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (refund_line_item_id)
  , PRIMARY KEY                       (refund_line_item_id)
  , FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
  , FOREIGN KEY (order_line_id) REFERENCES uos.order_line_items(order_line_id)
  , FOREIGN KEY (refund_id) REFERENCES uos.refunds(refund_id)
)
DISTSTYLE KEY
DISTKEY(order_line_id)
INTERLEAVED SORTKEY(order_line_id, order_id, refund_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    refund_line_item_id               CHAR(32)
  , store_refund_line_item_id         VARCHAR(64)
  , refund_id                         CHAR(32)
  , order_id                          CHAR(32)
  , order_line_id                     CHAR(32)
  , quantity                          BIGINT
  , refund_line_amount                DECIMAL(20,4)
  , refund_line_tax_amount            DECIMAL(20,4)
  , created_at                        TIMESTAMP_NTZ
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY                       (refund_line_item_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (order_id) REFERENCES uos.orders(order_id)
  , CONSTRAINT fkey_2 FOREIGN KEY (order_line_id) REFERENCES uos.order_line_items(order_line_id)
  , CONSTRAINT fkey_3 FOREIGN KEY (refund_id) REFERENCES uos.refunds(refund_id)
)
CLUSTER BY(order_line_id, order_id, refund_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    refund_line_item_id               STRING(32)
  , store_refund_line_item_id         STRING(64)
  , refund_id                         STRING(32)
  , order_id                          STRING(32)
  , order_line_id                     STRING(32)
  , quantity                          BIGINT
  , refund_line_amount                BIGDECIMAL(20,4)
  , refund_line_tax_amount            BIGDECIMAL(20,4)
  , created_at                        TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- FULFILLMENTS TABLE (TIES TO ORDER LINE ID WITH QUANTITY TO ALLOW FOR SPLIT SHIPMENTS)
CREATE TABLE IF NOT EXISTS uos.fulfillments
-- REDSHIFT BEGIN
(
    fulfillment_id                    CHAR(32) ENCODE ZSTD
  , store_fulfillment_id              VARCHAR(64) ENCODE ZSTD
  , order_id                          CHAR(32) ENCODE ZSTD
  , fulfillment_status                VARCHAR(64) ENCODE ZSTD
  , fulfillment_location_id           CHAR(32) ENCODE ZSTD
  , fulfillment_location              VARCHAR(255) ENCODE ZSTD
  , shipping_name                     VARCHAR(255) ENCODE ZSTD
  , shipping_company                  VARCHAR(255) ENCODE ZSTD
  , shipping_address1                 VARCHAR(255) ENCODE ZSTD
  , shipping_address2                 VARCHAR(255) ENCODE ZSTD
  , shipping_city                     VARCHAR(255) ENCODE ZSTD
  , shipping_state                    VARCHAR(255) ENCODE ZSTD
  , shipping_country                  VARCHAR(255) ENCODE ZSTD
  , shipping_zipcode                  VARCHAR(64) ENCODE ZSTD
  , shipping_phone_number             VARCHAR(64) ENCODE ZSTD
  , shipping_phone_number_clean       VARCHAR(64) ENCODE ZSTD
  , shipping_state_code               VARCHAR(255) ENCODE ZSTD
  , shipping_country_code             VARCHAR(64) ENCODE ZSTD
  , shipping_first_name               VARCHAR(255) ENCODE ZSTD
  , shipping_last_name                VARCHAR(255) ENCODE ZSTD
  , shipping_latitude                 DOUBLE PRECISION ENCODE ZSTD
  , shipping_longitude                DOUBLE PRECISION ENCODE ZSTD
  , shipment_status                   VARCHAR(64) ENCODE ZSTD
  , tracking_company                  VARCHAR(255) ENCODE ZSTD
  , tracking_number                   VARCHAR(64) ENCODE ZSTD
  , original_currency                 CHAR(3) ENCODE ZSTD
  , currency_conversion_rate          DECIMAL(20,4) ENCODE AZ64
  , converted_currency                CHAR(3) ENCODE ZSTD
  , fulfillment_cost                  DECIMAL(20,4) ENCODE AZ64
  , shipping_cost                     DECIMAL(20,4) ENCODE AZ64
  , fulfillment_date                  TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , estimated_arrival_date            TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , delivery_date                     TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , created_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , updated_at                        TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (fulfillment_id)
  , PRIMARY KEY                       (fulfillment_id)
)
DISTSTYLE KEY
DISTKEY(fulfillment_id)
INTERLEAVED SORTKEY(fulfillment_id, fulfillment_date)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    fulfillment_id                    CHAR(32)
  , store_fulfillment_id              VARCHAR(64)
  , order_id                          CHAR(32)
  , fulfillment_status                VARCHAR(64)
  , fulfillment_location_id           CHAR(32)
  , fulfillment_location              VARCHAR(255)
  , shipping_name                     VARCHAR(255)
  , shipping_company                  VARCHAR(255)
  , shipping_address1                 VARCHAR(255)
  , shipping_address2                 VARCHAR(255)
  , shipping_city                     VARCHAR(255)
  , shipping_state                    VARCHAR(255)
  , shipping_country                  VARCHAR(255)
  , shipping_zipcode                  VARCHAR(64)
  , shipping_phone_number             VARCHAR(64)
  , shipping_phone_number_clean       VARCHAR(64)
  , shipping_state_code               VARCHAR(255)
  , shipping_country_code             VARCHAR(64)
  , shipping_first_name               VARCHAR(255)
  , shipping_last_name                VARCHAR(255)
  , shipping_latitude                 DOUBLE PRECISION
  , shipping_longitude                DOUBLE PRECISION
  , shipment_status                   VARCHAR(64)
  , tracking_company                  VARCHAR(255)
  , tracking_number                   VARCHAR(64)
  , original_currency                 CHAR(3)
  , currency_conversion_rate          DECIMAL(20,4)
  , converted_currency                CHAR(3)
  , fulfillment_cost                  DECIMAL(20,4)
  , shipping_cost                     DECIMAL(20,4)
  , fulfillment_date                  TIMESTAMP WITHOUT TIME ZONE
  , estimated_arrival_date            TIMESTAMP WITHOUT TIME ZONE
  , delivery_date                     TIMESTAMP WITHOUT TIME ZONE
  , created_at                        TIMESTAMP WITHOUT TIME ZONE
  , updated_at                        TIMESTAMP WITHOUT TIME ZONE
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE
  , CONSTRAINT pkey PRIMARY KEY       (fulfillment_id)
)
CLUSTER BY(fulfillment_id, fulfillment_date)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    fulfillment_id                    STRING(32)
  , store_fulfillment_id              STRING(64)
  , order_id                          STRING(32)
  , fulfillment_status                STRING(64)
  , fulfillment_location_id           STRING(32)
  , fulfillment_location              STRING(255)
  , shipping_name                     STRING(255)
  , shipping_company                  STRING(255)
  , shipping_address1                 STRING(255)
  , shipping_address2                 STRING(255)
  , shipping_city                     STRING(255)
  , shipping_state                    STRING(255)
  , shipping_country                  STRING(255)
  , shipping_zipcode                  STRING(64)
  , shipping_phone_number             STRING(64)
  , shipping_phone_number_clean       STRING(64)
  , shipping_state_code               STRING(255)
  , shipping_country_code             STRING(64)
  , shipping_first_name               STRING(255)
  , shipping_last_name                STRING(255)
  , shipping_latitude                 BIGDECIMAL
  , shipping_longitude                BIGDECIMAL
  , shipment_status                   STRING(64)
  , tracking_company                  STRING(255)
  , tracking_number                   STRING(64)
  , original_currency                 STRING(3)
  , currency_conversion_rate          BIGDECIMAL(20,4)
  , converted_currency                STRING(3)
  , fulfillment_cost                  BIGDECIMAL(20,4)
  , shipping_cost                     BIGDECIMAL(20,4)
  , fulfillment_date                  TIMESTAMP
  , estimated_arrival_date            TIMESTAMP
  , delivery_date                     TIMESTAMP
  , created_at                        TIMESTAMP
  , updated_at                        TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;


-- FULFILLMENTS TABLE (TIES TO ORDER LINE ID WITH QUANTITY TO ALLOW FOR SPLIT SHIPMENTS)
CREATE TABLE IF NOT EXISTS uos.order_item_fulfillments
-- REDSHIFT BEGIN
(
    order_item_fulfillment_id         CHAR(32) ENCODE ZSTD
  , store_order_item_fulfillment_id   VARCHAR(255) ENCODE ZSTD
  , order_line_id                     CHAR(32) ENCODE ZSTD
  , fulfillment_id                    CHAR(32) ENCODE ZSTD
  , variant_id                        CHAR(32) ENCODE ZSTD
  , sku                               VARCHAR(255) ENCODE ZSTD
  , ordered_quantity                  INT ENCODE AZ64
  , remaining_to_fulfill              INT ENCODE AZ64
  , item_fulfillment_status           VARCHAR(255) ENCODE ZSTD
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (order_item_fulfillment_id)
  , PRIMARY KEY                       (order_item_fulfillment_id)
  , FOREIGN KEY (order_line_id) REFERENCES uos.order_line_items(order_line_id)
  , FOREIGN KEY (fulfillment_id) REFERENCES uos.fulfillments(fulfillment_id)
)
DISTSTYLE KEY
DISTKEY(order_line_id)
INTERLEAVED SORTKEY(order_line_id, fulfillment_id)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    order_item_fulfillment_id         CHAR(32)
  , store_order_item_fulfillment_id   VARCHAR(255)
  , order_line_id                     CHAR(32)
  , fulfillment_id                    CHAR(32)
  , variant_id                        CHAR(32)
  , sku                               VARCHAR(255)
  , ordered_quantity                  INT
  , remaining_to_fulfill              INT
  , item_fulfillment_status           VARCHAR(255)
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (order_item_fulfillment_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (order_line_id) REFERENCES uos.order_line_items(order_line_id)
  , CONSTRAINT fkey_2 FOREIGN KEY (fulfillment_id) REFERENCES uos.fulfillments(fulfillment_id)
)
CLUSTER BY(order_line_id, fulfillment_id)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    order_item_fulfillment_id         STRING(32)
  , store_order_item_fulfillment_id   STRING(255)
  , order_line_id                     STRING(32)
  , fulfillment_id                    STRING(32)
  , variant_id                        STRING(32)
  , sku                               STRING(255)
  , ordered_quantity                  INT
  , remaining_to_fulfill              INT
  , item_fulfillment_status           STRING(255)
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;



-- INVENTORY LEVELS (DAILY SNAPSHOT OF INVENTORY ON A DAILY BASIS)
CREATE TABLE IF NOT EXISTS uos.inventory_levels
-- REDSHIFT BEGIN
(
    inventory_level_id                CHAR(32) ENCODE ZSTD
  , store_inventory_id                VARCHAR(64) ENCODE ZSTD
  , location_id                       CHAR(32) ENCODE ZSTD
  , location_name                     VARCHAR(255) ENCODE ZSTD
  , inventory_item_id                 CHAR(32) ENCODE ZSTD
  , variant_id                        CHAR(32) ENCODE ZSTD
  , listing_sku                       VARCHAR(255) ENCODE ZSTD
  , sku                               VARCHAR(255) ENCODE ZSTD
  , inventory_quantity                BIGINT ENCODE AZ64
  , available_quantity                BIGINT ENCODE AZ64
  , committed_quantity                BIGINT ENCODE AZ64
  , in_transit_quantity               BIGINT ENCODE AZ64
  , on_order_quantity                 BIGINT ENCODE AZ64
  , back_order_quantity               BIGINT ENCODE AZ64
  , inventory_date                    TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __shop_id                         VARCHAR(255) ENCODE ZSTD
  , __uos_source                      VARCHAR(64) ENCODE ZSTD
  , __uos_integration_id              CHAR(36) ENCODE ZSTD
  , __loaded_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , __synced_at                       TIMESTAMP WITHOUT TIME ZONE ENCODE AZ64
  , UNIQUE                            (inventory_level_id)
  , PRIMARY KEY                       (inventory_level_id)
  , FOREIGN KEY (variant_id) REFERENCES uos.product_variants(variant_id)
)
DISTSTYLE KEY
DISTKEY(inventory_item_id)
INTERLEAVED SORTKEY(inventory_item_id, inventory_date)
-- REDSHIFT END
-- SNOWFLAKE BEGIN
(
    inventory_level_id                CHAR(32)
  , store_inventory_id                VARCHAR(64)
  , location_id                       CHAR(32)
  , location_name                     VARCHAR(255)
  , inventory_item_id                 CHAR(32)
  , variant_id                        CHAR(32)
  , listing_sku                       VARCHAR(255)
  , sku                               VARCHAR(255)
  , inventory_quantity                BIGINT
  , available_quantity                BIGINT
  , committed_quantity                BIGINT
  , in_transit_quantity               BIGINT
  , on_order_quantity                 BIGINT
  , back_order_quantity               BIGINT
  , inventory_date                    TIMESTAMP_NTZ
  , __shop_id                         VARCHAR(255)
  , __uos_source                      VARCHAR(64)
  , __uos_integration_id              CHAR(36)
  , __loaded_at                       TIMESTAMP_NTZ
  , __synced_at                       TIMESTAMP_NTZ
  , CONSTRAINT pkey PRIMARY KEY       (inventory_level_id)
  , CONSTRAINT fkey_1 FOREIGN KEY (variant_id) REFERENCES uos.product_variants(variant_id)
)
CLUSTER BY(inventory_item_id, inventory_date)
-- SNOWFLAKE END
-- BIGQUERY BEGIN
(
    inventory_level_id                STRING(32)
  , store_inventory_id                STRING(64)
  , location_id                       STRING(32)
  , location_name                     STRING(255)
  , inventory_item_id                 STRING(32)
  , variant_id                        STRING(32)
  , listing_sku                       STRING(255)
  , sku                               STRING(255)
  , inventory_quantity                BIGINT
  , available_quantity                BIGINT
  , committed_quantity                BIGINT
  , in_transit_quantity               BIGINT
  , on_order_quantity                 BIGINT
  , back_order_quantity               BIGINT
  , inventory_date                    TIMESTAMP
  , __shop_id                         STRING(255)
  , __uos_source                      STRING(64)
  , __uos_integration_id              STRING(36)
  , __loaded_at                       TIMESTAMP
  , __synced_at                       TIMESTAMP
)
-- BIGQUERY END
;