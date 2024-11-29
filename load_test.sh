#!/bin/bash

echo "Testing simple db record lookups (no relations)"
echo ""

echo "php-fpm (nginx) - 10 records (small load)"
wrk -t12 -c12 -d10s http://localhost:8880/api/users?limit=10
echo ""

echo "nginx unit - 10 records (small load)"
wrk -t12 -c12 -d10s http://localhost:8881/api/users?limit=10
echo ""

echo "laravel octane swoole - 10 records (small load)"
wrk -t12 -c12 -d10s http://localhost:8882/api/users?limit=10
echo ""

echo "php-fpm (nginx) - 100 records (medium load)"
wrk -t12 -c12 -d10s http://localhost:8880/api/users?limit=100
echo ""

echo "nginx unit - 100 records (medium load)"
wrk -t12 -c12 -d10s http://localhost:8881/api/users?limit=100
echo ""

echo "laravel octane swoole - 100 records (medium load)"
wrk -t12 -c12 -d10s http://localhost:8882/api/users?limit=100
echo ""

echo "php-fpm (nginx) - 1000 records (high load)"
wrk -t12 -c12 -d10s http://localhost:8880/api/users?limit=1000
echo ""

echo "nginx unit - 1000 records (high load)"
wrk -t12 -c12 -d10s http://localhost:8881/api/users?limit=1000
echo ""

echo "laravel octane swoole - 1000 records (high load)"
wrk -t12 -c12 -d10s http://localhost:8882/api/users?limit=1000
echo ""

echo "Testing complex db record lookups (2 layers of relations)"
echo ""

echo "php-fpm (nginx) - 10 records (small load)"
wrk -t12 -c12 -d10s http://localhost:8880/api/comments?limit=10
echo ""

echo "nginx unit - 10 records (small load)"
wrk -t12 -c12 -d10s http://localhost:8881/api/comments?limit=10
echo ""

echo "laravel octane swoole - 10 records (small load)"
wrk -t12 -c12 -d10s http://localhost:8882/api/comments?limit=10
echo ""

echo "php-fpm (nginx) - 100 records (medium load)"
wrk -t12 -c12 -d10s http://localhost:8880/api/comments?limit=100
echo ""

echo "nginx unit - 100 records (medium load)"
wrk -t12 -c12 -d10s http://localhost:8881/api/comments?limit=100
echo ""

echo "laravel octane swoole - 100 records (medium load)"
wrk -t12 -c12 -d10s http://localhost:8882/api/comments?limit=100
echo ""

echo "php-fpm (nginx) - 1000 records (high load)"
wrk -t12 -c12 -d10s http://localhost:8880/api/comments?limit=1000
echo ""

echo "nginx unit - 1000 records (high load)"
wrk -t12 -c12 -d10s http://localhost:8881/api/comments?limit=1000
echo ""

echo "laravel octane swoole - 1000 records (high load)"
wrk -t12 -c12 -d10s http://localhost:8882/api/comments?limit=1000
echo ""
