package org.opensource.pasut.yus.injection
{
	public interface Mapper
	{
		function map(type:Class):MappingBuilder;
		function get mappings():Vector.<Mapping>;
	}
}