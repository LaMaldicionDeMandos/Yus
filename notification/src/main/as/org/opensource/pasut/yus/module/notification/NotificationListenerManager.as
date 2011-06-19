package org.opensource.pasut.yus.module.notification
{
	internal interface NotificationListenerManager extends EventDispatcher
	{
		function addListener(messageClass:Class,listener:Function):void;
	}
}