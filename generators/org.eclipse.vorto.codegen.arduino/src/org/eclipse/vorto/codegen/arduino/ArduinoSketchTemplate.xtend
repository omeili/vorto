/*******************************************************************************
 *  Copyright (c) 2017 Oliver Meili
 *  All rights reserved. This program and the accompanying materials
 *  are made available under the terms of the Eclipse Public License v1.0
 *  and Eclipse Distribution License v1.0 which accompany this distribution.
 *   
 *  The Eclipse Public License is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 *  The Eclipse Distribution License is available at
 *  http://www.eclipse.org/org/documents/edl-v10.php.
 *   
 *  Contributors:
 *  Oliver Meili <omi@ieee.org>
 *******************************************************************************/
package org.eclipse.vorto.codegen.arduino

import org.eclipse.vorto.core.api.model.informationmodel.InformationModel
import org.eclipse.vorto.codegen.api.InvocationContext

class ArduinoSketchTemplate extends ArduinoTemplate<InformationModel> {
	
	override getFileName(InformationModel model) {
		return model.name + ".ino";
	}
	
	override getPath(InformationModel model) {
		return model.name
	}
	
	override getContent(InformationModel model, InvocationContext context) {
		'''
		// Generated by Vorto from «model.namespace».«model.name»:«model.version»
		
		#define USE_SECURE_CONNECTION 1
		
		#include <PubSubClient.h>
		#include <ESP8266WiFi.h>
		#if (USE_SECURE_CONNECTION == 1)
		    #include <WiFiClientSecure.h>
		#endif
		«FOR fb : model.properties»
		#include "«fb.type.name».h"
		«ENDFOR»
		#include "«model.name».h"
		
		/**************************************************************************/
		/* Configuration section, adjust to your settings                         */
		/**************************************************************************/
		
		/* Your tenant in Eclipse Hono / Bosch IoT Hub */
		#define TENANT "«context.configurationProperties.getOrDefault("tenant","DEFAULT_TENANT")»"
		
		/* Define the period of data transmission in ms */
		#define MQTT_DATA_PERIOD 10000
		
		/* Define the buffer size for payload strings */
		#define MQTT_MAX_SIZE  50
		
		/* MQTT broker endpoint */
		const char* mqttServer = "«context.configurationProperties.getOrDefault("mqttServer","<ENTER YOUR MQTT BROKER DNS NAME>")»";
		const char* usernameDevice = "«context.configurationProperties.getOrDefault("mqttUsername","<ENTER THE DEVICE USERNAME HERE>")»";
		const char* passwordDevice = "«context.configurationProperties.getOrDefault("mqttPassword","<ENTER THE DEVICE PASSWORD HERE>")»";
		
		
		#if (USE_SECURE_CONNECTION == 1)
		    /* SHA-1 fingerprint of the server certificate of the MQTT broker, UPPERCASE and spacing */
		    const char* mqttServerFingerprint = "<xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx>";
		#endif

		/* WiFi Configuration */
		const char* ssid = "<ENTER YOUR WIFI SSID>";
		const char* password = "<ENTER YOUR WIFI PASSWORD>";
		
		/* Device Configuration */
		String deviceId = "«context.configurationProperties.getOrDefault("deviceId","nodemcu-")»»";
			
		/* BEGIN SAMPLE CODE */
		/* Sample numeric */
		long value = 0;
		
		/* Sample text value */
		char msg[MQTT_MAX_SIZE];
		/* END SAMPLE CODE */
		
		/**************************************************************************/
		/* Implementation                                                         */
		/**************************************************************************/
		
		/* Port on which the MQTT broker is listening */
		#if (USE_SECURE_CONNECTION == 1)
		    #define MQTT_SERVER_PORT 8883
		#else
		    #define MQTT_SERVER_PORT 1883
		#endif

		/* Topic on which the telemetry data is published */
		String telemetryTopic = String("telemetry/") + String(TENANT) + String("/");
		
		/* This variables stores the client ID in the MQTT protocol */
		String mqttClientId;
		
		/* Timestamp of previous data transmission */
		long lastMqttMsg;
		
		/* Setup WiFi mqttClient and MQTT mqttClient */
		#if (USE_SECURE_CONNECTION == 1)
		    WiFiClientSecure wifiClient;
		#else
		    WiFiClient wifiClient;
		#endif
		PubSubClient mqttClient(wifiClient);
		
		/* The information model object */
		«model.name» infoModel;
		
		/**************************************************************************/
		/* Function to connect to the WiFi network                                */
		/**************************************************************************/
		void setup_wifi() {
		
		    delay(10);
		  
		    /* We start by connecting to a WiFi network */
		    WiFi.begin(ssid, password);
		
		    /* Wait for succesful connection, hang if there is none? */
		    while (WiFi.status() != WL_CONNECTED) {
		        delay(500);
		    }
		
		    randomSeed(micros());
		
		    Serial.println("WiFi connected");
		    Serial.print("IP address: ");
		    Serial.println(WiFi.localIP());
		    Serial.print("MAC address: ");
		    Serial.println(WiFi.macAddress());
		}
		
		/**************************************************************************/
		/* Function called when data on a subscribed topic arrives                */
		/**************************************************************************/
		void mqttDataReceived(char* topic, byte* payload, unsigned int length) {
			
		    /* BEGIN SAMPLE CODE */
		     
		    /* Switch on the builtin LED if a "1" was received as first character for any topic, 
		       switch the LED off otherwise */ 
		    if ((char)payload[0] == '1') {
		  	    /* The LED is switched on LOW signal */
		        digitalWrite(BUILTIN_LED, LOW);
		    } else {
		  	    /* The LED is switched off on HIGH signal */
		        digitalWrite(BUILTIN_LED, HIGH);
		    }
		    
		    /* END SAMPE CODE */
		}
		
		/**************************************************************************/
		/* Reconnect to MQTT broker in case the connection dropped                */
		/**************************************************************************/
		void reconnect()
		{
		    /* Loop while not connected */
		    while (!mqttClient.connected())
		    {		    
		
		        /* If connected to the MQTT broker... */
		        if (mqttClient.connect(mqttClientId.c_str(),usernameDevice,passwordDevice))
		        {
		            /* Re-subscribe */
		            /* SAMPLE CODE */
		            
		            String topic = telemetryTopic + "/led";
		            mqttClient.subscribe(topic.c_str());
		            
		            /* END SAMPLE CODE */
		        } else {
		    	    /* otherwise wait for 5 seconds before retrying */
		            delay(5000);
		        }
		    }
		}
		
		void setup() {
		    pinMode(BUILTIN_LED, OUTPUT);     // Initialize the BUILTIN_LED pin as an output
		    Serial.begin(115200);
		    
		    setup_wifi();
		  
		    /* Create a the MQTT client from the deviceId prefix and the MAC address of the WiFi chip */
		    mqttClientId = deviceId;
		    mqttClientId += WiFi.macAddress();
		    
		    Serial.print("Device ID: ");
		    Serial.println(mqttClientId);
		    
		    /* Add the client ID to the telemetry topic as the final element */
		    telemetryTopic += mqttClientId;
		  
		    /* Configure the MQTT client with the server and callback data */
		    mqttClient.setServer(mqttServer, MQTT_SERVER_PORT);
		    mqttClient.setCallback(mqttDataReceived);

		    #if (USE_SECURE_CONNECTION == 1)
		        if (!wifiClient.connect(mqttServer, MQTT_SERVER_PORT)) {
		            /* Secure connection failed, start over */
			        ESP.restart();
		        }
		        else
		        {
		        	Serial.println("Successfully established secure connection to broker");
				}
				
		        if (!wifiClient.verify(mqttServerFingerprint, mqttServer)) {
		            /* Verify failed, start over */
			        ESP.restart();
		        }
		        else
		        {
		        	Serial.println("Successfully verified server certificate");
		        }
		    #endif
		}
		
		void loop() {
		
			/* Check if connection to MQTT broker is still good */
		    if (!mqttClient.connected()) {
		    	/* Reconnect if not */
		        reconnect();
		    }
		    
		    /* Event handling of the MQTT client */
		    mqttClient.loop();
		
		    /* Publish the telemetry data periodically */
		    long now = millis();
		    if (now - lastMqttMsg > MQTT_DATA_PERIOD) {
		        lastMqttMsg = now;
		        
		        /* SAMPLE CODE */
		        value++;
		        snprintf(msg, MQTT_MAX_SIZE - 1, "hello world #%ld", value);
		        
		        «FOR fb : model.properties»
		        	«FOR status : fb.type.functionblock.status.properties»
		        		«IF isNumericType(status.type)»
		        			infoModel.«fb.name».set«status.name»(value);
		        		«ELSE»
		        			infoModel.«fb.name».set«status.name»(msg);
		        		«ENDIF»
		        	«ENDFOR»
		        «ENDFOR»
		        /* END OF SAMPLE CODE */
		        
		        String mqttPayload = infoModel.serialize();
		        
		        /* Debug output on console */
		        Serial.print("Publishing ");
		        Serial.print(mqttPayload);
		        Serial.print(" to topic ");
		        Serial.println(telemetryTopic);
		        
		        /* Publish all available data to the MQTT broker */
		        if (!mqttClient.publish(telemetryTopic.c_str(), mqttPayload.c_str()))
		        {
		        	Serial.println("Publish failed, if this happens repeatedly increase MQTT_MAX_PACKET_SIZE in PubSubClient.h");
		        }
		    }
		}
		'''
	}		
}

