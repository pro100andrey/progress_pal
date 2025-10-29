# Progress Pal Seeder

This package contains a CLI utility for synchronizing PocketBase schemas and data with `pull` and `push` operations. It also includes data files used to seed the `Progress Pal` application with initial data. The seeding process helps set up the application with predefined collections, records, and configurations necessary for development and testing.

## Features

- **Schema Synchronization**: Pull and push PocketBase collection schemas
- **Data Seeding**: Import seed data from JSON files into PocketBase collections
- **Batch Processing**: Configurable batch sizes for efficient data import (max 50 records per batch)
- **Truncate Option**: Option to clear existing collections before seeding
- **Schema Comparison**: Intelligent schema comparison to avoid unnecessary updates

## Dotenv Configuration

Create a `.env` file in the root of the `seeder` directory with the following content:

```env
PB_URL="localhost:8090"
PB_ADMIN_EMAIL="admin@example.com"
PB_ADMIN_PASSWORD="your_admin_password"
```

## CLI Usage

To use the CLI utility, navigate to the `seeder` directory and run the following commands:

### Pull Command

Pulls the remote PocketBase schema and collection data into local JSON files:

```bash
dart run seeder/bin/seeder.dart -v -e seeder/.env -d seeder/data pull
```

### Push Command

Pushes the local PocketBase schema and seed data to the remote instance:

```bash
# Basic push
dart run seeder/bin/seeder.dart -v -e seeder/.env -d seeder/data push

# Push with custom batch size (1-50 records per batch)
dart run seeder/bin/seeder.dart -v -e seeder/.env -d seeder/data push --batch-size 30

# Push with truncate option (clears collections before seeding)
dart run seeder/bin/seeder.dart -v -e seeder/.env -d seeder/data push --truncate

# Combined options
dart run seeder/bin/seeder.dart -v -e seeder/.env -d seeder/data push -b 25 -t
```

### Command Options

#### Global Options

- `-v, --verbose`: Enable verbose logging
- `-e, --env`: Path to environment file (default: `.env`)
- `-d, --data`: Path to data directory containing JSON files

#### Push Command Options

- `-b, --batch-size`: Number of records to create per batch (1-50, default: 20)
- `-t, --truncate`: Truncate existing collections before import

## Data Structure

The seeder expects JSON files in the data directory corresponding to PocketBase collections. The tool will:

1. Import the schema from a schema file
2. Compare local and remote schemas to detect changes
3. Seed collections with data from JSON files
4. Handle batch processing for large datasets
5. Provide options to truncate collections before seeding to prevent duplicates

## Safety Features

- **Duplicate Prevention**: The tool checks for existing data and warns before seeding to prevent duplicates
- **Schema Validation**: Compares local and remote schemas before making changes
- **Interactive Confirmation**: Prompts for confirmation when truncating collections (if terminal is attached)
- **Batch Size Limits**: Enforces maximum batch size of 50 records for optimal performance
