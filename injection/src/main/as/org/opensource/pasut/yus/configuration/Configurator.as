package org.opensource.pasut.yus.configuration
{
	import org.opensource.pasut.yus.injection.Mapper;

	public interface Configurator
	{
		function configure(mapper:Mapper):void;
	}
}