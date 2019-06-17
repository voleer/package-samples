# Greeting

Template `greeting` is an example of a simple automation that can be created using Voleer.

It introduces few additional Voleer template building blocks:

- Using step type `sequence` to execute steps sequentially.
- Workflow inputs.
- Using expressions to combine multiple values as task inputs.

The template contains the following steps:

- First step uses task `echo` to output its input to the log file.
- Second step uses task `send-email` from package `sendgrid` to submit email for delivery.
