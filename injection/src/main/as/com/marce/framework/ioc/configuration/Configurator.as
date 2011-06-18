package com.marce.framework.ioc.configuration
{
	import com.marce.framework.ioc.injection.Mapper;

	public interface Configurator
	{
		function configure(mapper:Mapper):void;
	}
}