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

The Unified Order Schema (UOS) is a data model initially designed by the Daasity (http://www.daasity.com) team that helps accelerate development of analytical capability by normalizing all commerce data: eCommerce, Marketplace, Retail and Wholesale. The normalized schema was designed to support complex fulfillment logic like split shipments and multiple delivery groups and be extensible for edge cases like product customization or personalization.

UOS is split into core tables, required to support an order across multiple commerce channels, and secondary tables that are required to provide functionality to the business. Core tables are built off the concepts of Customer, Product, Order, Fulfillment and Location which all required components of a consumer product purchase.

For product, Brands will use different naming conventions for their merchandising hierarchy from Class, Category, Sub-Category to Style or Product (which can have different meaning) and Item or SKU. This Commerce schema limits tables to Product (want some might call a Style) and Product Variant (what some might call an Item or SKU).

Refer to the UOS documentation here: https://github.com/Daasity/commerce-data-models/wiki/Unified-Order-Schema-(UOS)


# Questions / Support
For any questions or suggestions feel free to reach out to our team at commerce-data-models@daasity.com

# License
[Apache 1.0](https://github.com/Daasity/commerce-data-models?tab=Apache-2.0-1-ov-file)

# Copyright
© 2024 Daasity, Inc.,

