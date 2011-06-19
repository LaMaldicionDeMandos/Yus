package org.opensource.pasut.yus.module.notification
{
	internal interface NotificationMapperManager extends EventDispatcher
	{
		function map(message:Class,listener:Object,handlerName:String):void;
	}
}