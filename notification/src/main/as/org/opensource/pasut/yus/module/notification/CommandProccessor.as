package org.opensource.pasut.yus.module.notification
{	
	
	import org.as3commons.reflect.Constructor;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Parameter;
	import org.as3commons.reflect.Type;
	import org.opensource.pasut.yus.Injector;
	import org.opensource.pasut.yus.configuration.MappingProccessor;
	import org.opensource.pasut.yus.injection.Mapping;
	
	internal class CommandProccessor implements MappingProccessor{

		public function CommandProccessor()
		{
		}
		
		public function proccess(mapping:Mapping):void
		{
			proccessClass(getType(mapping));
		}
		
		private function getType(mapping:Mapping):Type{
			//if(mapping.singleton!=null) return Type.forInstance(mapping.singleton);
			return (mapping.to!=null)? Type.forClass(mapping.to) : Type.forClass(mapping.type);
		}
		
		private function proccessClass(type:Type):void{
			var metadatas:Array = type.getMetadata("Command");
			if(metadatas==null || metadatas.length==0) return;
			proccessAsCommand(type);
		}
		
		private function proccessAsCommand(type:Type):void{
			var method:Method = getExecuteMethod(type);
			if(method.parameters.length != 1) throw new Error("The Execute Method of command " + type.fullName + " must have only one paramether");
			
			var parameter:Parameter = method.parameters[0];
			var mapper:NotificationMapper = Injector.getByType(NotificationMapper) as NotificationMapper;
			mapper.addCommand(parameter.type.clazz,type.clazz);
		}
		
		private function getExecuteMethod(type:Type):Method{
			var methods:Array = type.getMetadataContainers("Execute");
			if(methods==null || methods.length!=1) throw new Error("The command " + type.fullName + " must has only one execute method");
			
			if(!(methods[0] is Method)) throw new Error("The metadata tag named \"Execute\" must is over a method");
			
			return methods[0] as Method;
		}
	}
}