/*
 * generated by Xtext 2.15.0
 */
package com.truneo.hdl.ide

import com.google.inject.Guice
import com.truneo.hdl.HDLRuntimeModule
import com.truneo.hdl.HDLStandaloneSetup
import org.eclipse.xtext.util.Modules2

/**
 * Initialization support for running Xtext languages as language servers.
 */
class HDLIdeSetup extends HDLStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new HDLRuntimeModule, new HDLIdeModule))
	}
	
}
