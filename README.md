PowerShell IT Automation Toolkit

A beginner-friendly PowerShell toolkit designed to automate common Windows system checks and provide basic troubleshooting information.

Project Overview

I built this project to learn how PowerShell can be used for IT support and system troubleshooting.

The toolkit automates several checks that would otherwise require manually looking through Windows settings or running individual commands.

Features

The current version of the toolkit can:

\-Collect selected system information

\-Display computer and user information

\-Check C: drive storage

\-Calculate used and available disk space

\-Warn when available storage falls below a defined threshold

\-Test internet connectivity

\-Test DNS resolution

\-Check selected Windows services

\-Display service status and startup type

\-Display active network configuration

\-Show IPv4 address, default gateway, and DNS server information

Technologies Used

\-PowerShell

\-Windows

\-PowerShell cmdlets

\-Conditional logic

\-Windows service management

\-Basic network troubleshooting

How It Works

The main script is:

SystemHealthCheck.ps1

When executed, the script performs several diagnostic checks and presents the results in separate sections.

System Health

The script retrieves basic computer information and checks the C: drive.

It calculates:

\-Total disk space

\-Used disk space

\-Available disk space

It also evaluates available storage against a 50 GB warning threshold.

If available storage is below 50 GB, the script reports a warning. Otherwise, it reports that storage is OK.

Network Connectivity

The script uses:

\-Test-Connection to test connectivity to an external IP address

\-Resolve-DnsName to test DNS resolution

The results are reported as PASS or FAIL.

Windows Services

The toolkit checks selected Windows services:

\-Windows Update

\-Microsoft Defender Antivirus

\-Print Spooler

The script reports each service's current status and startup type.

Network Configuration

The script retrieves information about the active network interface, including:

\-Network interface

\-IPv4 address

\-Default gateway

\-DNS server

This information can help provide context when troubleshooting network connectivity.

Troubleshooting During Development

The project did not work perfectly on the first attempt.

When I initially tried to run the PowerShell script, PowerShell returned an error stating that running scripts was disabled.

I investigated the PowerShell execution policy using:

Get-ExecutionPolicy -List

The policy scopes were undefined, so I checked the effective policy with:

Get-ExecutionPolicy

The result was:

Restricted

I learned that PowerShell execution policies can restrict script execution as a security feature.

I temporarily allowed scripts to run for the current PowerShell session so I could test the project rather than permanently changing the system-wide policy.

Troubleshooting Lesson

One of the most useful lessons from this project was learning not to assume that every unexpected result represents a problem.

For example, the Windows Update service initially appeared as stopped.

I investigated it with:

Get-Service -Name wuauserv | Format-List Name, DisplayName, Status, StartType

The service was stopped with a Manual startup type.

This taught me that troubleshooting requires understanding the expected behavior and configuration of a system before deciding that something is broken.

What I Learned

Through this project, I practiced:

\-Creating and running PowerShell scripts

\-Using PowerShell cmdlets

\-Selecting specific information from command output

\-Working with variables

\-Performing calculations

\-Using conditional if/else logic

\-Querying Windows services

\-Checking network connectivity

\-Testing DNS resolution

\-Retrieving network configuration

\-Investigating PowerShell execution policies

\-Troubleshooting unexpected results

\-Documenting technical problems and their resolutions

Screenshots

Screenshots showing the toolkit running and producing diagnostic results are included in the screenshots directory.

Future Improvements

Potential future improvements include:

\-Adding additional system health checks

\-Adding more network diagnostics

\-Improving the formatting of the output

\-Adding additional troubleshooting checks

\-Generating a saved diagnostic report

Project Status

Version 1.0 — Completed

This project was built incrementally while learning PowerShell. The goal was not simply to create a working script, but to understand what each component does and document the troubleshooting process along the way.

