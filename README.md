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
    Latency     7.58ms    3.63ms  38.01ms   83.26%
    Req/Sec   134.78     50.63   250.00     59.08%
  16130 requests in 10.01s, 40.11MB read
Requests/sec:   1611.27
Transfer/sec:      4.01MB

nginx unit - 10 records (small load)
Running 10s test @ http://localhost:8881/api/users?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.88ms  386.20us  18.13ms   88.37%
    Req/Sec   205.70      7.00   222.00     93.33%
  24593 requests in 10.02s, 56.17MB read
Requests/sec:   2454.43
Transfer/sec:      5.61MB

laravel octane swoole - 10 records (small load)
Running 10s test @ http://localhost:8882/api/users?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     7.01ms   19.84ms 151.31ms   94.15%
    Req/Sec   409.44     94.25   515.00     88.99%
  48525 requests in 10.01s, 111.44MB read
Requests/sec:   4847.39
Transfer/sec:     11.13MB

php-fpm (nginx) - 100 records (medium load)
Running 10s test @ http://localhost:8880/api/users?limit=100
  12 threads and 12 connections
^@  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     8.20ms    2.66ms  20.27ms   69.89%
    Req/Sec   122.38     29.32   181.00     64.00%
  14646 requests in 10.01s, 123.87MB read
Requests/sec:   1462.89
Transfer/sec:     12.37MB

nginx unit - 100 records (medium load)
Running 10s test @ http://localhost:8881/api/users?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     6.40ms    1.05ms  19.42ms   79.06%
    Req/Sec   156.79     14.63   180.00     82.58%
  18773 requests in 10.02s, 154.85MB read
Requests/sec:   1873.31
Transfer/sec:     15.45MB

laravel octane swoole - 100 records (medium load)
Running 10s test @ http://localhost:8882/api/users?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     7.03ms   16.51ms 155.64ms   95.94%
    Req/Sec   249.34     46.75   323.00     84.14%
  29503 requests in 10.01s, 243.69MB read
Requests/sec:   2946.97
Transfer/sec:     24.34MB

php-fpm (nginx) - 1000 records (high load)
Running 10s test @ http://localhost:8880/api/users?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    24.82ms    6.75ms  51.13ms   70.01%
    Req/Sec    40.27      9.64    70.00     39.08%
  4832 requests in 10.01s, 329.65MB read
Requests/sec:    482.79
Transfer/sec:     32.94MB

nginx unit - 1000 records (high load)
Running 10s test @ http://localhost:8881/api/users?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    21.09ms    2.71ms  37.15ms   65.52%
    Req/Sec    47.40      5.01    60.00     68.83%
  5690 requests in 10.01s, 386.91MB read
Requests/sec:    568.17
Transfer/sec:     38.63MB

laravel octane swoole - 1000 records (high load)
Running 10s test @ http://localhost:8882/api/users?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    20.45ms    8.29ms 171.73ms   98.96%
    Req/Sec    50.07      9.65    80.00     35.79%
  5996 requests in 10.01s, 407.79MB read
Requests/sec:    598.84
Transfer/sec:     40.73MB

Testing complex db record lookups (2 layers of relations)

php-fpm (nginx) - 10 records (small load)
Running 10s test @ http://localhost:8880/api/comments?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    17.96ms    5.44ms  39.26ms   73.74%
    Req/Sec    55.68     14.00    90.00     46.92%
  6682 requests in 10.01s, 86.80MB read
Requests/sec:    667.28
Transfer/sec:      8.67MB

nginx unit - 10 records (small load)
Running 10s test @ http://localhost:8881/api/comments?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    14.74ms    2.06ms  51.43ms   82.95%
    Req/Sec    67.89      6.35    80.00     71.92%
  8149 requests in 10.01s, 104.14MB read
Requests/sec:    813.94
Transfer/sec:     10.40MB

laravel octane swoole - 10 records (small load)
Running 10s test @ http://localhost:8882/api/comments?limit=10
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    13.37ms   12.51ms 177.70ms   98.06%
    Req/Sec    83.50     12.94   111.00     67.84%
  9960 requests in 10.01s, 127.40MB read
Requests/sec:    994.78
Transfer/sec:     12.72MB

php-fpm (nginx) - 100 records (medium load)
Running 10s test @ http://localhost:8880/api/comments?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   108.53ms   29.86ms 219.09ms   75.14%
    Req/Sec     9.79      2.96    20.00     80.52%
  1102 requests in 10.01s, 119.31MB read
Requests/sec:    110.06
Transfer/sec:     11.92MB

nginx unit - 100 records (medium load)
Running 10s test @ http://localhost:8881/api/comments?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    96.47ms   10.18ms 151.27ms   71.51%
    Req/Sec    10.45      2.54    20.00     91.36%
  1239 requests in 10.02s, 133.85MB read
Requests/sec:    123.68
Transfer/sec:     13.36MB

laravel octane swoole - 100 records (medium load)
Running 10s test @ http://localhost:8882/api/comments?limit=100
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   100.79ms   19.22ms 269.12ms   70.03%
    Req/Sec    10.20      2.84    20.00     86.83%
  1187 requests in 10.03s, 128.25MB read
Requests/sec:    118.31
Transfer/sec:     12.78MB

php-fpm (nginx) - 1000 records (high load)
Running 10s test @ http://localhost:8880/api/comments?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.01s   256.60ms   1.93s    72.81%
    Req/Sec     0.54      0.50     1.00     53.51%
  114 requests in 10.02s, 122.39MB read
Requests/sec:     11.38
Transfer/sec:     12.22MB

nginx unit - 1000 records (high load)
Running 10s test @ http://localhost:8881/api/comments?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   976.90ms  143.57ms   1.40s    69.75%
    Req/Sec     0.51      0.50     1.00     51.26%
  119 requests in 10.04s, 127.68MB read
Requests/sec:     11.85
Transfer/sec:     12.72MB

laravel octane swoole - 1000 records (high load)
Running 10s test @ http://localhost:8882/api/comments?limit=1000
  12 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.10s   252.09ms   1.86s    78.64%
    Req/Sec     0.26      0.44     1.00     74.04%
  104 requests in 10.06s, 111.59MB read
  Socket errors: connect 0, read 0, write 0, timeout 1
Requests/sec:     10.34
Transfer/sec:     11.09MB
```
