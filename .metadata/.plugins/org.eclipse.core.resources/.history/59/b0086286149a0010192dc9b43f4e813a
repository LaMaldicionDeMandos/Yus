package org.opensource.pasut.yus.injection
{	
	import org.opensource.pasut.yus.Injector;
	
	import flash.utils.Dictionary;
	
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.Constructor;
	import org.as3commons.reflect.Field;
	import org.as3commons.reflect.IMetadataContainer;
	import org.as3commons.reflect.Metadata;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Parameter;
	import org.as3commons.reflect.Type;
	import org.as3commons.reflect.Variable;

	internal class Provider
	{
		protected var clazz:Class;
		public function Provider(clazz:Class){
			this.clazz = clazz;
		}
		
		[override]
		public function getObject():Object{
			return null;
		}
		
		public function inject(object:Object):Object{
			var type:Type = Type.forInstance(object);
			var accessors:Array = type.getMetadataContainers("Inject");
			for each(var accessor:IMetadataContainer in accessors){
				injectAttribute(accessor,object);
			}
			return object;
		}
		
		public function initObject(object:Object):void{
			var type:Type = Type.forInstance(object);
			var containers:Array = type.getMetadataContainers("PostConstruct");
			for each(var container:IMetadataContainer in containers){
				if(container is Method){
					var metadatas:Array = container.getMetadata("Argument");
					var arguments:Array = createArguments(Method(container).parameters,metadatas);
					Method(container).invoke(object,arguments);
				}
			}
			
		}
		
		private function injectAttribute(accessor:IMetadataContainer,object:Object):void{
			if(accessor is Accessor)
				injectAccessor(accessor as Accessor,object);
			else if(accessor is Variable)
				injectField(accessor as Field,object);
		}
		
		private function injectAccessor(accessor:Accessor, object:Object):void{
			if(accessor.writeable){
				injectField(accessor,object);
			}
		}
		
		private function injectField(field:Field, object:Object):void{
			var metadatas:Array = field.getMetadata("Inject");
			if(metadatas.length==0) return;
			var metadata:Metadata = metadatas[0] as Metadata;
			if(metadata.arguments.length==0)
				object[field.name] = getFieldValue(field);
			else
				object[field.name] = getFieldValue(field,metadata.getArgument("name").value);
		}
		
		private function createMetadataMap(metadatas:Array):Dictionary{
			var metadataMap:Dictionary = new Dictionary();
			for each(var metadata:Metadata in metadatas){
				metadataMap[new Number(metadata.getArgument("index").value)] = metadata.getArgument("name").value;
			}
			return metadataMap;
		}
		
		protected function createArguments(parameters:Array,metadatas:Array):Array{
			var arguments:Array = [];
			var metadataMap:Dictionary = createMetadataMap(metadatas);
			for each(var argument:Parameter in parameters){
				var namedArgument:Object = metadataMap[argument.index];
				var object:Object = createArgument(argument,namedArgument as String);
				if(object!=null || !argument.isOptional)
					arguments.push(object);
			}
			return arguments;
		}
		
		private function getFieldValue(field:Field,named:String=null):Object{
			if(named)
				return Injector.getByName(named);
			
			var type:String = field.type.fullName;
			return Injector.getByName(type);
		}
		
		protected function createArgument(argument:Parameter,namedArgument:String):Object{
			if(namedArgument)
				return Injector.getByName(namedArgument);
			
			var type:String = argument.type.fullName;
			return Injector.getByName(type);
		}
	}
}