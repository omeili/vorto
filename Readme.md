[![Build Status](https://travis-ci.org/eclipse/vorto.svg?branch=development)](https://travis-ci.org/eclipse/vorto)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/569649bfe2594bedae2cd172e5ee0741)](https://www.codacy.com/app/alexander-edelmann/vorto?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=eclipse/vorto&amp;utm_campaign=Badge_Grade)
[![Quality Gate](https://sonarqube.com/api/badges/gate?key=org.eclipse.vorto%3Aorg.eclipse.vorto.parent%3Adevelopment)](https://sonarqube.com/dashboard/index/org.eclipse.vorto:org.eclipse.vorto.parent:development) 
[![Maven Central](https://maven-badges.herokuapp.com/maven-central/org.eclipse.vorto/org.eclipse.vorto.parent/badge.svg)](https://maven-badges.herokuapp.com/maven-central/org.eclipse.vorto/org.eclipse.vorto.parent)

# Getting started with Vorto

[Vorto](http://www.eclipse.org/vorto) provides tools and services to describe devices with simple language and manage these descriptions as Information Models in a [Vorto Repository](http://vorto.eclipse.org). Using [code generators](http://vorto.eclipse.org/#/generators) you can generate source code for devices to easily integrate them with various IoT platforms.

Learn more about how to use Vorto in our [tutorial section](tutorials/Readme.md). 
 
 <img src="./tutorials/images/vorto_overview.png" width="90%"/>

## 1. Describe a device with Vorto

Use the Vorto Eclipse Toolset to describe the functionality of a device. [Read the Tutorial](tutorials/tutorial-create_and_publish_with_web_editor.md)

## 2. Generate Source Code  

Integrate a device for a given Information Model into IoT platforms with Vorto Code Generators:

1. Open the [Vorto Repository](http://vorto.eclipse.org)
2. Search for, e.g. [**Bosch XDK**](http://vorto.eclipse.org/#/details/com.bosch.devices/XDK/1.0.0)
3. Select **Eclipse Kura Generator**, choose your configuration (e.g. **BLE**) and confirm with **Generate**.
4. Download the generated Kura bundle and **import** it into your Eclipse
5. That's it! Use the generated device-specific OSGI Kura bundle to read XDK sensor values via Bluetooth and send the data to a cloud backend. 

[Read Tutorial](tutorials/tutorial_connect_xdk_ble.md).

# Developer Guide

## Generator SDK

With the **Generator SDK** you can "_teach_" Vorto how to integrate an Information model, and thus device, into an IoT platform. [Read the Tutorial](tutorials/tutorial_create_generator.md)

Here is a list of currently supported [Vorto Generators](http://vorto.eclipse.org/#/generators)

## Repository Client API

Access models and generate code via the [Repository Client API](server/repo/repository-java-client/Readme.md)

## Data Mapping API

Learn more about, how to map arbitrary device data, such as JSON or BLE GATT, to Vorto compliant Eclipse Ditto payload. [Data Mapping API](server/repo/repository-mapping/Readme.md)  

# Documentation

- Read our [tutorials](tutorials/Readme.md)
- Read our [Vorto Documentation](http://www.eclipse.org/vorto/documentation/overview/introduction.html)

# Contact us
 - You want to chat with us ? [![Join the chat at https://gitter.im/eclipse/vorto](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/eclipse/vorto?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
 - You have problems with Vorto ? Open a [GitHub issue](https://github.com/eclipse/vorto/issues)
 - Find out more about the project on our [Vorto Homepage](http://www.eclipse.org/vorto)
 - Reach out to our developers on our [Discussion Forum](http://eclipse.org/forums/eclipse.vorto) 

# Contribute to the Project

Make sure, that you have installed [Vorto for contributors](tutorials/tutorial_vortosetup_contributors.md)

When you create a Pull Request, make sure:

1. You have a valid CLA signed with Eclipse
2. All your commits are signed off (git commit -s)
3. Your commit message contains "Fixes #`<Github issue no>`
4. Target to merge your fix is development branch



