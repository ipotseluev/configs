In this guide, we will review available IDE solutions for remote Rust debugging, primarily running on EC2 instances with sudo privileges.

Note: There may be some gaps or inaccuracies with current features, so feel free to fix and maintain this document.

## Common

I couldn't find any information on whether it's possible to specify a private key in the GDB(LLDB) server remote command, so need to set up SSH port forwarding.

For example:

```
sudo ssh -i ~/.ssh/mhnap-hp.pem ubuntu@ec2-3-143-254-66.us-east-2.compute.amazonaws.com -L 1234:localhost:1234 -f sleep 60m
```

> <sub>[Source](https://stackoverflow.com/questions/27061624/remote-debugging-using-gdbserver-over-ssh)</sub>

In such a case, it would need to set only the local host and port in IDE settings.

# VSCode
### Debug on remote

Firstly, we need to install [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb) extension.

From CodeLLDB [docs](https://github.com/vadimcn/codelldb/blob/v1.10.0/MANUAL.md#remote-debugging) there are two options for remote debugging: [lldb-server agent](https://github.com/vadimcn/codelldb/blob/v1.10.0/MANUAL.md#connecting-to-lldb-server-agent) and [gdbserver-style agent](https://github.com/vadimcn/codelldb/blob/v1.10.0/MANUAL.md#connecting-to-a-gdbserver-style-agent). First is less manual, but for some unknown reasons `lldb-server platform` didn't work correctly in my case (similar to [this](https://stackoverflow.com/questions/72553030/lldb-debugging-using-lldb-server-on-android/72592346#72592346) and [this](https://github.com/vadimcn/codelldb/issues/101)), so we will go with the second option.


On a host machine:
1. Copy binary executable, for example:
```
scp -i ~/.ssh/mhnap-hp.pem ./target/debug/elastio ubuntu@ec2-3-128-29-126.us-east-2.compute.amazonaws.com:/home/ubuntu/
```

2. Add (or create) to VSCode `launch.json` remote debug configuration:
```
        {
            "type": "lldb",
            "request": "custom",
            "name": "Debug remote executable 'elastio'",
            "targetCreateCommands": ["target create ${workspaceFolder}/target/debug/elastio"],
            "processCreateCommands": ["gdb-remote localhost:1234"]
        },
```

On a remote machine:
1. Install `lldb-server` if not installed.
2. (Optional) Export any environment variables.
3. Run it with the necessary options, for example:
```
sudo -E lldb-server g :1234 -- /home/ubuntu/elastio ebs import-snapshot --snapshot-id snap-0ab05303d9c79fbd5 --foreground
```

Now, you can start VSCode debugging as usual.

Note, that this setup requires to copy binary each after each change manually. You can try to automate this using custom VSCode tasks or script as [here](https://stackoverflow.com/questions/68888706/remote-debug-of-rust-program-in-visual-studio-code).

# JetBrains products


## RustRover
### Run on remote (RustRover)
> <sub>[More info](https://www.jetbrains.com/help/rust/2023.3/cargo-run-debug-configuration.html)</sub>

Add a new Cargo configuration with a remote SSH target in the IDE:
1. Add a new `Cargo` configuration.
2. Add a new SSH target with an EC2 instance host, username, and private key data.

By default, this configuration will copy the source tree and binary to the remote target and execute it.

Also, there is an option to build on the remote target, but obviously, the whole Rust toolchain should be installed on the target in such a case.

Note: There is an option to run with root privileges, but last time checked, it didn't work with remote target.

### Debug on remote (RustRover)
Last time checked, [previously added](https://github.com/elastio/elastio/wiki/Remote-Rust-debugging#run-on-remote-rustrover) Cargo configuration didn't allow debugging remote targets, and there was no support of [other remote debug configurations](https://github.com/elastio/elastio/wiki/Remote-Rust-debugging#debug-on-remote-clion).
> <sub>I have created an [issue](https://youtrack.jetbrains.com/issue/RUST-12791/Add-Remote-Debug-and-Remote-GDB-Server-configurations) to add such support.</sub>


## CLion
### Run on remote (CLion)
The same as for the [RustRover](https://github.com/elastio/elastio/wiki/Remote-Rust-debugging#run-on-remote-rustrover).

### Debug on remote (CLion)
> <sub>[More info](https://www.jetbrains.com/help/clion/remote-debug-via-gdb-gdbserver.html)</sub>

There are two different remote debug configurations: `Remote GDB Server` and `Remote Debug`.

`Remote GDB Server` configuration is less manual compared to `Remote Debug`, but it's also less flexible and doesn't support LLDB.

#### Remote GDB Server Configuration
> <sub>[More info](https://www.jetbrains.com/help/clion/remote-gdb-server.html)</sub>

First, need to install `gdbserver` on a remote machine.

Next, need to add a new remote debug configuration in the IDE:
1. Add a new `Remote GDB Server` configuration.
2. Add a dummy target (maybe can be configured correctly, but not mandatory).
3. Select executable.
4. Select GDB binary (recommended to use `rust-gdb`).
5. Add a new SSH target with an EC2 instance host, username, and private key data.

This configuration will copy the binary to the remote target and execute the `gdbserver` there, and also execute the `gdb` client with the remote parameters on the host machine.

Also can specify additional arguments in `Advanced GDB Server Options`.

The final configuration looks like this:
![image](https://github.com/elastio/elastio/assets/17296656/aae50747-0a8a-4cb2-8c64-2ea075d86bb8)

#### Remote Debug Configuration
> <sub>[More info](https://www.jetbrains.com/help/clion/remote-debug.html)</sub>

We will go with LLDB in this example.

On a remote machine:
1. Copy binary executable, for example:
```
scp -i ~/.ssh/mhnap-hp.pem ./target/debug/elastio ubuntu@ec2-3-128-29-126.us-east-2.compute.amazonaws.com:/home/ubuntu/elastio/v3/
```

2. Install `lldb-server` if not installed.
3. (Optional) Export any environment variables.
4. Run it with the necessary options, for example:
```
sudo -E lldb-server g :1234 -- /home/ubuntu/elastio/v3/elastio ebs import-snapshot --snapshot-id snap-0ab05303d9c79fbd5 --foreground
```

Next, need to add a new remote debug configuration in the IDE:
1. Add a new `Remote Debug` configuration.
2. Select `Bundled LLDB` debugger.
3. Specify `connect://127.0.0.1:1234` in the `'process connect' url` field.
4. Select a symbol file (can be executable).

This configuration will execute the `lldb` client with the remote parameters on the host machine.

The final configuration looks like this:
![image](https://github.com/elastio/elastio/assets/17296656/73ad5860-0e8c-4352-950c-3211f4c1eae9)


## Gateway﻿
> <sub>[More info](https://www.jetbrains.com/remote-development/gateway/)</sub>

Gateway is primarily designed to be used for remote development, and obviously, it should support remote debugging as well.

Last time checked, it was possible to run and debug without any additional configurations, but for some reason, root privileges didn't work and gave some error. Maybe this problem can be resolved easily somehow, but still, I decided not to use Gateway cause it has too big latency for development and needed to set up the whole Rust toolchain and clone the project on a remote target.

