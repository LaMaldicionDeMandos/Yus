package org.opensource.pasut.yus.module.localzation
{
	import flash.utils.Dictionary;
	
	import org.as3commons.bytecode.interception.IInterceptor;
	import org.as3commons.bytecode.interception.IMethodInvocation;
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.Metadata;
	import org.as3commons.reflect.MetadataContainer;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;
	import org.opensource.pasut.yus.Injector;
	
	public class LocalizationInterceptor implements IInterceptor
	{
		private var type:Type;
		private var localizedaccessors:Dictionary;
		public function LocalizationInterceptor(type:Type)
		{
			this.type = type;
			createLocalizedAccessors();
		}
		
		private function createLocalizedAccessors():void{
			localizedaccessors = new Dictionary();
			for each(var method:Method in type.methods){
				var metadatas:Array = method.getMetadata("Localized");
				if(metadatas!=null && metadatas.length>0)
					localizedaccessors[method.name] = method;
			}
			for each(var accessor:Accessor in type.accessors){
				metadatas = accessor.getMetadata("Localized");
				if(metadatas!=null && metadatas.length>0)
					localizedaccessors[accessor.name] = accessor;
			}
		}
		
		public function intercept(invocation:IMethodInvocation):void
		{
			trace("TARGET: " + invocation.targetInstance);
			if(invocation.targetMember!=null){
				var metadata:MetadataContainer = localizedaccessors[invocation.targetMember.localName] as MetadataContainer;
				if(metadata!=null)
					proccessInvocation(invocation,metadata);
			}
		}
		
		private function proccessInvocation(invocation:IMethodInvocation, container:MetadataContainer):void{
			var metadata:Metadata = container.getMetadata("Localized")[0];
			var key:String = metadata.getArgument("key").value;
			var paramProperties:Array = metadata.hasArgumentWithKey("vars")
				? metadata.getArgument("vars").value.split(",")
				: [];
			var params:Array = getParams(invocation.targetInstance,paramProperties);
			var localeService:LocaleService = Injector.getByType(LocaleService) as LocaleService;
			invocation.proceed = false;
			invocation.returnValue = localeService.getString.apply(this,[key].concat(params));
		}
		
		private function getParams(target:Object, params:Array):Array{
			var _params:Array = [];
			for each(var paramName:String in params){
				if(type.getMethod(paramName)!=null){
					_params.push(target[paramName]());					
				}
				else
					_params.push(target[paramName]);
			}
			return _params;
		}
	}
}