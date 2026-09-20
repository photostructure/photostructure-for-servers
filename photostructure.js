#!/usr/bin/env node
// Copyright © 2026, PhotoStructure Inc.
// BY RUNNING THIS SOFTWARE YOU AGREE TO ALL THE TERMS OF THIS LICENSE:
// https://photostructure.com/eula

const { spawnSync } = require("node:child_process");
const { delimiter, dirname, join } = require("node:path");

// npm must shim a Node entry point: Windows does not provide /bin/sh.
process.env.NODE_ENV = "production";
const paths = [dirname(process.execPath), process.env.PATH || ""];
if (process.platform !== "win32") {
  if (process.platform === "darwin") {
    paths.push("/opt/homebrew/bin", "/opt/homebrew/sbin");
  }
  paths.push(
    "/usr/local/bin",
    "/usr/local/sbin",
    "/opt/local/bin",
    "/opt/local/sbin",
    "/usr/lib/libraw",
    "/usr/sbin",
    "/usr/bin",
    "/sbin",
    "/bin",
  );
}
process.env.PATH = paths.join(delimiter);

// Bootstrap may install dependencies or update bundles. Wait for it to finish
// successfully before loading the CLI, and preserve failures in npm's shims.
const bootstrap = spawnSync(
  process.execPath,
  [join(__dirname, "bin/bootstrap.js"), ...process.argv.slice(2)],
  { stdio: "inherit" },
);
if (bootstrap.error) throw bootstrap.error;
if (bootstrap.status !== 0) process.exit(bootstrap.status ?? 1);

// Keep the CLI in this process so its exit status and signal handlers reach
// callers directly, without another long-lived child-process wrapper.
process.argv[1] = join(__dirname, "bin/photostructure.js");
require("./bin/photostructure.js");
