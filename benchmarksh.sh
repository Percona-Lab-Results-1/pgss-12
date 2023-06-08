#!/bin/bash

# PostgreSQL connection details
HOST="localhost"
PORT="5432"
DATABASE="your_database"
USER="your_username"
PASSWORD="your_password"

# Benchmark settings
ITERATIONS=100
CONCURRENCY=10

# Enable pg_stat_monitor extension
psql -h $HOST -p $PORT -d $DATABASE -U $USER -c "CREATE EXTENSION IF NOT EXISTS pg_stat_monitor;"

# Enable pg_stat_statements extension
psql -h $HOST -p $PORT -d $DATABASE -U $USER -c "CREATE EXTENSION IF NOT EXISTS pg_stat_statements;"

# Clear pg_stat_monitor data
psql -h $HOST -p $PORT -d $DATABASE -U $USER -c "SELECT pg_stat_monitor_reset();"

# Clear pg_stat_statements data
psql -h $HOST -p $PORT -d $DATABASE -U $USER -c "SELECT pg_stat_statements_reset();"

# Run the benchmark for pg_stat_monitor
echo "Running benchmark for pg_stat_monitor..."
for ((i=1; i<=$ITERATIONS; i++)); do
    echo "Iteration $i:"
    for ((j=1; j<=$CONCURRENCY; j++)); do
        psql -h $HOST -p $PORT -d $DATABASE -U $USER -c "SELECT * FROM your_table WHERE your_condition;"
    done
done

# Run the benchmark for pg_stat_statements
echo "Running benchmark for pg_stat_statements..."
for ((i=1; i<=$ITERATIONS; i++)); do
    echo "Iteration $i:"
    for ((j=1; j<=$CONCURRENCY; j++)); do
        psql -h $HOST -p $PORT -d $DATABASE -U $USER -c "SELECT * FROM your_table WHERE your_condition;"
    done
done

