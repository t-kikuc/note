---
title: "ecstop: My CLI Tool to Stop ECS Resources Easily"
published: true
description: "Introduction of ecstop, my CLI tool."
tags: ["AWS", "ECS", "go", "OSS"]
---

## Introduction

On December 20, 2024, I developed and released a CLI tool called **ecstop** that "quickly stops ECS resources in bulk".

https://github.com/t-kikuc/ecstop

The name ecstop is a combination of **ECS+Stop**. I pronounce it as "ee-c-stop".

In this article, I'll introduce the overview, philosophy, and future prospects of ecstop.

## Summary in 3 Lines

- ecstop can **quickly stop ECS services, tasks, and container instances (EC2) in bulk**.
- The main purpose is to easily reduce costs in dev environments.
- After `brew install t-kikuc/tap/ecstop`, you're ready to use immediately without any configuration file.

## Development Background

I often created ECS resources when testing ECS itself or developing/testing [PipeCD](https://pipecd.dev).

Since ECS charges for running tasks and container instances, I wanted to stop unused ones.

As it's for testing, I didn't want to delete clusters or services. They're free.

However, as I created many resources, it was troublesome to stop them one by one from the AWS console.

- To stop a service from the console, you need to  go to the ECS console,  select the service and "update",  set the number of tasks to 0 and "confirm update" for each service.

- IaC and deployment tools are designed for production use and require careful configuration file changes, which isn't suitable for "quickly stopping multiple resources".

I had been using shell scripts/Go to stop them in bulk, but I often forgot how to call them.
Therefore, I decided to make a proper CLI tool.

## Installation

You can install ecstop with the following command (Homebrew):

```bash
$ brew install t-kikuc/tap/ecstop
```

To enable auto-completion, please refer to [here](https://github.com/t-kikuc/ecstop?tab=readme-ov-file#auto-completion).

## Features

For details on options, please refer to the [README](https://github.com/t-kikuc/ecstop).

### 1. Zero-scale Services

```bash
$ ecstop services --cluster xxx
```

This sets the `desiredCount` of all services in the xxx cluster to 0. This also automatically stops tasks linked to the services.

### 2. Stop Tasks

```bash
$ ecstop tasks --cluster xxx --standalone
```

The `--standalone` flag stops tasks that are not linked to services.

This applies to tasks whose `group` prefix is not `service:`.

To stop tasks linked to services, use `ecstop services` instead because services can start new tasks even after stopping by `ecstop tasks`.

### 3. Stop Container Instances (EC2)

```bash
$ ecstop instances --cluster xxx
```

This stops (≠ Terminate) all container instances linked to the xxx cluster.

### 4. Execute the Above Three in One Command

```bash
$ ecstop all --cluster xxx
```

This command is equivalent to:

```bash
$ ecstop services --cluster xxx
$ ecstop tasks --cluster xxx --standalone
$ ecstop instances --cluster xxx
```

### Other Useful Flags

- `--all-cluster`: Instead of `--cluster xxx`, this performs stop operations on all ECS clusters in the region.
- `--profile yyy`: You can specify the AWS profile.
- `--region zzz`: You can specify the AWS region.

## Philosophy

### 1. No Deletion

ecstop **does not delete unnecessary ECR images or task definitions**.

While tasks and container instances (EC2) have high operating costs, ECR images are relatively inexpensive, and task definitions are free, so I ignored them. Services and clusters themselves are also free, so they are not deleted.

For this reason, I didn't include "clean" or "delete" in the tool name.

In cases where "I want to delete it because it's not being used and is an eyesore", it's easier to select multiple items from the AWS console and delete them after human judgment.

Also, for cleaning up ECR images, it's good to use a tool called **ecrm** created by fujiwara-san.

https://github.com/fujiwara/ecrm

### 2. Specialized for Bulk Operations

I've minimized the selector options for "which resources to stop".

The AWS console is sufficient for stopping individual resources, and in a testing environment (not staging, etc.), there shouldn't be any resources that "absolutely must not be stopped". Especially at night, let's stop them.

## Future Prospects

- I want to regularly execute ecstop as a scheduled process on AWS (e.g., daily at 24:00).
  - It's troublesome to call it every time + AWS authentication is cumbersome from local.
  - I'm thinking of creating IaC for EventBridge+Lambda.
  - As it's for testing environments, completion notifications seem unnecessary. I'm not sure about error notifications.
- At the moment, I don't have any "I want to add this option".
  - If there are any requests, I'll consider them.

## Main Tools I Used

ecstop is based on a typical Go CLI development stack.

- Golang
- [cobra](https://github.com/spf13/cobra)
- [GoReleaser](https://goreleaser.com/)
- [Homebrew Taps](https://docs.brew.sh/Taps)

## Conclusion

This was my first time publishing a CLI tool, and I learned a lot, including how to define the philosophy.

If you have any feedback or requests, please let me know at https://github.com/t-kikuc/ecstop.

Actually, I'm developing another CLI tool related to ECS external deployment, which I plan to release soon.
