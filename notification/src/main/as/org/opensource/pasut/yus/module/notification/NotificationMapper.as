package org.opensource.pasut.yus.module.notification
{
	public interface NotificationMapper
	{
		function map(message:Class,listener:Object,handlerName:String):void;
		function addCommand(message:Class, command:Class):void;
	}
}