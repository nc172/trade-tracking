# Trade Tracker

Trade Tracker is a Ruby on Rails web application that helps traders upload brokerage performance CSV files, parse trade data, and review trading performance through dashboards, charts, and trade history.

The current version supports Tradovate-style CSV exports and focuses on futures trading analytics.

## Features

* User authentication with Devise
* CSV upload with Active Storage
* Tradovate CSV parser
* Automatic long/short detection based on buy/sell timestamps
* Trade database with individual trade detail pages
* Duplicate trade protection using fill IDs
* Dashboard performance summary
* Equity curve chart
* Daily P/L chart
* Wins vs losses chart
* Import history page
* Import summary counts:

  * processed rows
  * created trades
  * skipped duplicates
  * failed rows
* Dark glass-style UI built with Tailwind CSS

## Tech Stack

* Ruby on Rails 8
* PostgreSQL
* Devise
* Active Storage
* Tailwind CSS
* Chartkick
* Groupdate
* Importmap
* GitHub Actions

## Supported CSV Format

The current parser is designed for Tradovate-style CSV exports with columns such as:

```csv
symbol,_priceFormat,_priceFormatType,_tickSize,buyFillId,sellFillId,qty,buyPrice,sellPrice,pnl,boughtTimestamp,soldTimestamp,duration
```

The parser uses `boughtTimestamp` and `soldTimestamp` to determine trade direction:

* Buy before sell = long trade
* Sell before buy = short trade

It also parses profit/loss values such as:

```text
$165.00
$(75.00)
```

into numeric values for analytics.

## Dashboard Metrics

The dashboard currently shows:

* Total trades
* Net P/L
* Win rate
* Wins and losses
* Average win
* Average loss
* Profit factor
* Equity curve
* Daily P/L
* Win/loss distribution

## Duplicate Protection

Trade Tracker prevents duplicate imports by using the combination of:

```text
user_id + buy_fill_id + sell_fill_id
```

This prevents the same trade from being counted multiple times if a user uploads the same CSV file more than once.

## Project Structure

Important files:

```text
app/controllers/imports_controller.rb
app/controllers/trades_controller.rb
app/controllers/dashboard_controller.rb

app/models/user.rb
app/models/import.rb
app/models/trade.rb

app/services/imports/tradovate_csv_parser.rb

app/views/dashboard/index.html.erb
app/views/imports/
app/views/trades/
```

The CSV parser lives in:

```text
app/services/imports/tradovate_csv_parser.rb
```

This keeps parsing logic out of the controller and makes the import flow easier to maintain.

## Local Setup

Clone the repository:

```bash
git clone https://github.com/nc172/trade-tracking.git
cd trade-tracking
```

Install dependencies:

```bash
bundle install
```

Set up the database:

```bash
rails db:create
rails db:migrate
```

Start the development server:

```bash
bin/dev
```

Then open:

```text
http://localhost:3000
```

## Current Status

This project is in active development.

Completed MVP features include authentication, CSV upload, parsing, trade storage, duplicate protection, dashboard analytics, import history, and a styled UI.

## Roadmap

Planned features:

* Date range filters
* Symbol filters
* Import-level filtering
* Strategy tags
* Trade notes/journaling
* Session analysis
* Better chart controls
* PDF import support
* Background import jobs
* Improved test coverage
* Deployment
