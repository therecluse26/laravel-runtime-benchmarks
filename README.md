# Laravel Runtime Benchmarks

The purpose of this repo is to run various benchmark tests against various runtimes that Laravel can run on:

- PHP-FPM
- Nginx Unit
- Laravel Octane (Swoole)

If additional runtimes are wanted, please open an issue and I will add them.

## Data schema

The data schema is as follows:

- `users` table with 1000 rows
- `posts` table with 1000 rows, relates to `users`
- `comments` table with 1000 rows relates to `posts` and `users`

3 API endpoints are available:

- `/api/users` - returns all users
- `/api/posts` - returns all posts with related users
- `/api/comments` - returns all comments with related posts (with related users) and users

## Running the tests

To run the tests, you will need to have Docker installed on your machine.

```bash
docker compose up -d
```

This will start 3 docker containers - one for each runtime.

- PHP-FPM - http://localhost:8880
- Nginx Unit - http://localhost:8881
- Laravel Octane (swoole) - http://localhost:8882

To run the tests, run the following command:

```bash
./load_test.sh
```

#### Benchmark Results running on a System76 Pangolin with 32GB RAM and a 16-core AMD Ryzen 7 7735U

```plain text
Testing simple db record lookups (no relations)

php-fpm (nginx) - 10 records (small load)
Running 10s test @ http://localhost:8880/api/users?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   159.88ms   35.63ms 337.52ms   70.64%
    Req/Sec     7.05      2.59    10.00     51.01%
  743 requests in 10.03s, 1.85MB read
Requests/sec:     74.09
Transfer/sec:    188.62KB

nginx unit - 10 records (small load)
Running 10s test @ http://localhost:8881/api/users?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   159.70ms   19.44ms 275.44ms   77.90%
    Req/Sec     6.99      2.55    10.00     53.10%
  742 requests in 10.03s, 1.69MB read
Requests/sec:     73.98
Transfer/sec:    173.03KB

laravel octane swoole - 10 records (small load)
Running 10s test @ http://localhost:8882/api/users?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    12.66ms   29.41ms 311.02ms   96.04%
    Req/Sec   145.26     93.08   353.00     64.46%
  17073 requests in 10.06s, 54.21MB read
Requests/sec:   1697.28
Transfer/sec:      5.39MB

php-fpm (nginx) - 100 records (medium load)
Running 10s test @ http://localhost:8880/api/users?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   188.47ms   61.90ms 441.46ms   79.28%
    Req/Sec     6.12      2.70    10.00     52.68%
  634 requests in 10.03s, 5.36MB read
Requests/sec:     63.21
Transfer/sec:    547.37KB

nginx unit - 100 records (medium load)
Running 10s test @ http://localhost:8881/api/users?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   184.67ms   31.85ms 374.05ms   76.66%
    Req/Sec     5.80      2.33    10.00     70.02%
  647 requests in 10.04s, 5.34MB read
Requests/sec:     64.41
Transfer/sec:    544.04KB

laravel octane swoole - 100 records (medium load)
Running 10s test @ http://localhost:8882/api/users?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    12.52ms   30.22ms 278.31ms   95.85%
    Req/Sec   147.51     28.71   198.00     86.75%
  17248 requests in 10.03s, 142.46MB read
Requests/sec:   1719.50
Transfer/sec:     14.20MB

php-fpm (nginx) - 1000 records (high load)
Running 10s test @ http://localhost:8880/api/users?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   228.17ms   64.05ms 431.17ms   74.28%
    Req/Sec     4.76      2.01    10.00     83.11%
  521 requests in 10.02s, 35.54MB read
Requests/sec:     51.99
Transfer/sec:      3.55MB

nginx unit - 1000 records (high load)
Running 10s test @ http://localhost:8881/api/users?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   205.00ms   27.19ms 374.02ms   77.49%
    Req/Sec     4.96      1.57    10.00     81.10%
  582 requests in 10.06s, 39.58MB read
Requests/sec:     57.88
Transfer/sec:      3.94MB

laravel octane swoole - 1000 records (high load)
Running 10s test @ http://localhost:8882/api/users?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    31.29ms   14.89ms 288.53ms   97.46%
    Req/Sec    33.11      6.84    50.00     59.83%
  3961 requests in 10.04s, 269.39MB read
Requests/sec:    394.52
Transfer/sec:     26.83MB

Testing complex db record lookups (2 layers of relations)

php-fpm (nginx) - 10 records (small load)
Running 10s test @ http://localhost:8880/api/comments?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   207.23ms   55.92ms 435.08ms   77.26%
    Req/Sec     5.30      2.12    10.00     67.30%
  575 requests in 10.02s, 7.47MB read
Requests/sec:     57.40
Transfer/sec:    763.40KB

nginx unit - 10 records (small load)
Running 10s test @ http://localhost:8881/api/comments?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   190.83ms   21.02ms 297.16ms   71.59%
    Req/Sec     5.44      1.91    10.00     79.94%
  623 requests in 10.05s, 7.96MB read
Requests/sec:     61.98
Transfer/sec:    811.07KB

laravel octane swoole - 10 records (small load)
Running 10s test @ http://localhost:8882/api/comments?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    21.38ms   25.79ms 383.51ms   97.29%
    Req/Sec    55.67     11.44    80.00     72.47%
  6587 requests in 10.04s, 84.26MB read
Requests/sec:    656.24
Transfer/sec:      8.39MB

php-fpm (nginx) - 100 records (medium load)
Running 10s test @ http://localhost:8880/api/comments?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   355.08ms   81.14ms 646.39ms   72.07%
    Req/Sec     2.63      0.87     5.00     87.69%
  333 requests in 10.02s, 36.05MB read
Requests/sec:     33.22
Transfer/sec:      3.60MB

nginx unit - 100 records (medium load)
Running 10s test @ http://localhost:8881/api/comments?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   318.01ms   40.23ms 470.64ms   72.16%
    Req/Sec     2.89      0.73     5.00     69.46%
  370 requests in 10.02s, 39.97MB read
Requests/sec:     36.91
Transfer/sec:      3.99MB

laravel octane swoole - 100 records (medium load)
Running 10s test @ http://localhost:8882/api/comments?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   143.98ms   29.38ms 430.88ms   78.95%
    Req/Sec     7.76      2.61    10.00     58.53%
  832 requests in 10.05s, 89.89MB read
Requests/sec:     82.82
Transfer/sec:      8.95MB

php-fpm (nginx) - 1000 records (high load)
Running 10s test @ http://localhost:8880/api/comments?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.53s   296.69ms   1.99s    69.23%
    Req/Sec     0.05      0.22     1.00     95.16%
  62 requests in 10.02s, 66.56MB read
  Socket errors: connect 0, read 0, write 0, timeout 23
Requests/sec:      6.19
Transfer/sec:      6.64MB

nginx unit - 1000 records (high load)
Running 10s test @ http://localhost:8881/api/comments?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.63s    97.95ms   1.81s    62.50%
    Req/Sec     0.00      0.00     0.00    100.00%
  60 requests in 10.05s, 64.37MB read
  Socket errors: connect 0, read 0, write 0, timeout 12
Requests/sec:      5.97
Transfer/sec:      6.41MB

laravel octane swoole - 1000 records (high load)
Running 10s test @ http://localhost:8882/api/comments?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.33s   101.26ms   1.55s    63.93%
    Req/Sec     0.00      0.00     0.00    100.00%
  73 requests in 10.03s, 78.32MB read
  Socket errors: connect 0, read 0, write 0, timeout 12
Requests/sec:      7.28
Transfer/sec:      7.81MB
```
