package org.opensource.pasut.yus.configuration
{
	import org.opensource.pasut.yus.injection.Mapping;

	public interface MappingProccessor
	{
		function proccess(mapping:Mapping):void;
	}
}