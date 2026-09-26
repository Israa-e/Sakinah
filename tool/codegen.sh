#!/usr/bin/env bash
# Runs build_runner (Drift + riverpod_generator) under an exclusive lock so
# parallel callers don't corrupt .dart_tool/build.
cd "$(dirname "$0")/.." && exec flock tool/.codegen.lock dart run build_runner build -d "$@"
