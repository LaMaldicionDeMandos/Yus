package org.opensource.pasut.yus.module.notification
{
	import flash.utils.Dictionary;
	
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;
	import org.opensource.pasut.yus.Injector;

	internal class NotificationCommandManagerImpl implements NotificationCommandManager
	{
		private var map:Dictionary;
		
		public function NotificationCommandManagerImpl()
		{
			map = new Dictionary();
		}
		
		public function addCommand(message:Class, command:Class):void{
			var commands:Array = map[message];
			if(commands == null){
				commands = [];
				map[message] = commands;
			}
			commands.push(command);
		}
		
		public function dispatch(message:Object, clazz:Class):void
		{
			for each(var commandClazz:Class in map[clazz]){
				var command:Object = Injector.getByType(commandClazz);
				execute(command,message);
			}			
		}
		
		private function execute(command:Object, message:Object):void{
			var type:Type = Type.forInstance(command);
			var method:Method = getExecuteMethod(type);
			method.invoke(command,[message]);
		}
		
		private function getExecuteMethod(type:Type):Method{
			var methods:Array = type.getMetadataContainers("Execute");
			return methods[0] as Method;
		}
	}
}