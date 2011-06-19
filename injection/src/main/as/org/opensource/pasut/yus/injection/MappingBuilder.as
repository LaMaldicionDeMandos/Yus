package org.opensource.pasut.yus.injection
{
	public interface MappingBuilder
	{
		function map(type:Class):MappingBuilder;
		function named(name:String):MappingBuilder;
		function to(type:Class):MappingBuilder;
		function toFactory(type:Class):MappingBuilder;
		function toInstance(object:Object):MappingBuilder;
		function asSingleton():void;
		
		function get mappingName():String;
		function get mapping():Mapping;
	}
}