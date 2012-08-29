package org.opensource.pasut.yus.injection
{
	import org.as3commons.reflect.Type;

	internal class MappingImpl implements Mapping
	{
		private var _type:Class;
		private var _to:Class;
		private var _asSingleton:Boolean = false;
		private var _name:String;
		private var _toFactory:Class;
		private var _customCreator:YusCreator;
		
		private var _factory:BeanFactory;
		
		public function MappingImpl(type:Class)
		{
			if(type==null)
				throw new Error("El tipo no puede ser null");
			_type = type;
			to = type;
			_name = Type.forClass(_type).fullName;
		}
		
		public function get toFactory():Class{
			return _toFactory;
		}
		
		public function set toFactory(value:Class):void{
			_toFactory = value;
		}
		
		public function get name():String{
			return _name;
		}
		
		public function set name(value:String):void{
			_name = value;
			_asSingleton = true;
		}
		
		public function get type():Class{
			return _type;
		}
		
		public function get to():Class{
			return _to;
		}
		
		public function set to(value:Class):void{
			_to = value;
		}
		
		public function asSingleton():void{
			_asSingleton = true;
		}
		
		public function toInstance(object:Object):void{
			asSingleton();
			_factory = new SingletonBeanFactory(this,object);
		}
		
		public function copy():Mapping{
			var _copy:MappingImpl = new MappingImpl(_type);
			_copy.to = this.to;
			_copy._name = _name;
			_copy.toFactory = this.toFactory;
			if(_asSingleton)
				_copy.asSingleton();
			_copy._factory = _factory;
			return _copy;
		} 
		
		public function getInstance():Object{
			return factory.getObject();
		}
		
		public function get singleton():Object{
			if(!_asSingleton) return null;
			return factory.getObject();
		}
		
		private function get factory():BeanFactory{
			return (_asSingleton)? getFactoryAsSingleton() : getSimpleFactory(); 
		}
		
		private function getFactoryAsSingleton():BeanFactory{
			if(_factory==null || !(_factory is SingletonBeanFactory)){
				_factory = new SingletonBeanFactory(this);
			}
			return _factory;
		}
		
		private function getSimpleFactory():BeanFactory{
			if(_factory==null || (_factory is SingletonBeanFactory)){
				_factory = new BeanFactory(this);
			}
			return _factory;
		}
		
		public function get customCreator():YusCreator{
			return _customCreator;
		}
		
		public function set customCreator(value:YusCreator):void{
			_customCreator = value;
		}
	}
}