# SR-10281

Test case for https://github.com/apple/swift-corelibs-foundation/pull/2061

Requirements:

- Swift 5 (macOS)
- Docker (for Linux tests)

Run

```
./run.sh
```

to execute and log test results to `test.log`.

Note that it may take several runs to expose the `Fatal error: Trying to remove task, but it's not in the registry` when running with swift:5.0.0 on Linux, it doesn't happen all the time.
