package org.opensource.pasut.yus.injection
{
	public interface Mapping
	{
		function get name():String;
		function get type():Class;
		function get to():Class;
		function set to(value:Class):void;
		function get toFactory():Class;
		function set toFactory(value:Class):void;
		function get singleton():Object;
		function asSingleton():void;
		function toInstance(object:Object):void;
		function get customCreator():YusCreator;
		function set customCreator(value:YusCreator):void;
		
		function getInstance():Object;
		function copy():Mapping;
	}
}