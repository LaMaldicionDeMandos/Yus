package org.opensource.pasut.yus.injection
{
	public class SingletonBeanFactory extends BeanFactory
	{
		private var instance:Object;
		
		public function SingletonBeanFactory(mapping:MappingImpl, instance:Object=null)
		{
			super(mapping);
			this.instance = instance;
		}
		
		override public function getObject():Object{
			if(instance==null)
				instance = super.getObject();
			return instance;
		}
		
		
	}
}