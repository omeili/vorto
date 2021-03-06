/*******************************************************************************
 * Copyright (c) 2017 Bosch Software Innovations GmbH and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * and Eclipse Distribution License v1.0 which accompany this distribution.
 *   
 * The Eclipse Public License is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * The Eclipse Distribution License is available at
 * http://www.eclipse.org/org/documents/edl-v10.php.
 *   
 * Contributors:
 * Bosch Software Innovations GmbH - Please refer to git log
 *******************************************************************************/
package org.eclipse.vorto.codegen.ditto.schema.tasks.template;

import org.eclipse.vorto.codegen.api.ITemplate
import org.eclipse.vorto.codegen.api.InvocationContext
import org.eclipse.vorto.core.api.model.functionblock.Configuration
import org.eclipse.vorto.core.api.model.functionblock.FunctionblockModel

class PropertiesConfigurationValidationTemplate implements ITemplate<Configuration> {
	
	new() {
	}
	
	override getContent(Configuration configuration, InvocationContext invocationContext) {
		var fbm = configuration.eContainer.eContainer as FunctionblockModel;
		var definition = fbm.namespace + ":" + fbm.name + ":" + fbm.version;
				'''
			{
				"$schema": "http://json-schema.org/draft-04/schema#",
				"title": "Properties validation of definition <«definition»> for <config> properties",
				"type": "object",
				"properties": {
					«EntityValidationTemplate.handleProperties(configuration.properties, invocationContext).toString.trim»
				},
				«EntityValidationTemplate.calculateRequired(configuration.properties)»
			}
		'''
	}

}
