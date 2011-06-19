package org.opensource.pasut.yus.module.notification
{
	internal interface NotificationCommandManager extends EventDispatcher
	{
		function addCommand(message:Class, command:Class):void;
	}
}