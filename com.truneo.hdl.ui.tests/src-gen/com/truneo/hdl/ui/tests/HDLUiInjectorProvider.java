/*
 * generated by Xtext 2.15.0
 */
package com.truneo.hdl.ui.tests;

import com.google.inject.Injector;
import com.truneo.hdl.ui.internal.HdlActivator;
import org.eclipse.xtext.testing.IInjectorProvider;

public class HDLUiInjectorProvider implements IInjectorProvider {

	@Override
	public Injector getInjector() {
		return HdlActivator.getInstance().getInjector("com.truneo.hdl.HDL");
	}

}