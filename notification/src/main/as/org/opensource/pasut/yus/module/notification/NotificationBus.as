package org.opensource.pasut.yus.module.notification
{
	public interface NotificationBus
	{
		function addListener(messageClass:Class,listener:Function):void;
		function dispatch(message:Object):void;
	}
}