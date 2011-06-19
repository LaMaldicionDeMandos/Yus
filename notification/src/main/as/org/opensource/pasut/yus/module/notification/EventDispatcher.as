package org.opensource.pasut.yus.module.notification
{
	internal interface EventDispatcher
	{
		function dispatch(message:Object,clazz:Class):void;
	}
}