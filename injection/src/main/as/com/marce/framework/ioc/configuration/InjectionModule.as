package com.marce.framework.ioc.configuration
{
	public interface InjectionModule
	{
		function get configurator():Configurator;
		function get injectionProccessors():Array;
		function get mappingProccessors():Array;
	}
}