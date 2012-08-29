package org.opensource.pasut.yus.module.localzation
{
	import flash.events.Event;
	
	import org.as3commons.bytecode.interception.impl.BasicMethodInvocationInterceptor;
	import org.as3commons.bytecode.proxy.IProxyFactory;
	import org.as3commons.bytecode.proxy.event.ProxyFactoryEvent;
	import org.as3commons.bytecode.proxy.impl.ProxyFactory;
	import org.as3commons.reflect.Type;
	import org.opensource.pasut.yus.injection.YusCreator;
	
	public class LocalizationCreator implements YusCreator
	{
		private static var proxyFactory:IProxyFactory;
		private var type:Type;
		public function LocalizationCreator(proxyFactory:IProxyFactory, type:Type)
		{
			this.type = type;
			//this.proxyFactory = proxyFactory;
		}
		
		public function onComplete(event:Event):void{
			proxyFactory = event.target as IProxyFactory;
			proxyFactory.addEventListener(ProxyFactoryEvent.GET_METHOD_INVOCATION_INTERCEPTOR, createMethodInterceptor,false, 0, true);
		}
		
		public function create(type:Class, params:Array):Object
		{
			if(params==null || params.length==0)
				return proxyFactory.createProxy(type);
			else
				return proxyFactory.createProxy(type,params);
		}
		
		private function createMethodInterceptor(event:ProxyFactoryEvent):void {
			var interceptor:BasicMethodInvocationInterceptor = new event.methodInvocationInterceptorClass() as BasicMethodInvocationInterceptor;
			interceptor.interceptors[interceptor.interceptors.length] = new LocalizationInterceptor(type);
			event.methodInvocationInterceptor = interceptor;			
		}
	}
}