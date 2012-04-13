package hxunify.engine;

import hxunify.HxUnify;

class Fields 
{
	static public function getFields(o:Dynamic, inContext:Array<Dynamic>, unifyClassFields = false):{fields:Dynamic<RuntimeType>, circular:Array<String>}
	{
		var h:Dynamic<RuntimeType> = { };

		var fields = null;
		try {
			fields = Lambda.concat(Reflect.fields(o), Type.getClass(o) != null ? Type.getInstanceFields(Type.getClass(o)) : []);
		} catch (e:Dynamic)
		{
			// this might happen for arrays on php and js
			return { fields:h, circular: [] };
		}
		
		var circular = [];
		for (field in fields)
		{
			var fieldValue = Reflect.field(o, field);
			if (fieldValue != null)
			{
				switch(Type.typeof(fieldValue))
				{
					case TClass(cl):
						if (Lambda.has(inContext, cl))
						{
							circular.push(field);
							continue;
						}
					default:
				}
			}
			Reflect.setField(h, field, HxUnify.typeOf(Reflect.field(o, field), unifyClassFields, inContext));
		}
		return { fields: h, circular: circular };
	}
	
	#if flash9
	static public function getClassFields(o:Dynamic, c:Class<Dynamic>, inContext:Array<Dynamic>, unifyClassFields = false)
	{
		var h:Dynamic<RuntimeType> = {};
		var xml : flash.xml.XML = untyped __global__["flash.utils.describeType"](c);
		var vars = xml.factory[0].child("variable");
		for( i in 0...vars.length() ) {
			var f = vars[i].attribute("name").toString();
			if( !o.hasOwnProperty(f) )
				continue;
			switch(Type.typeof(Reflect.field(o, f)))
			{
				case TClass(cl):
					if (Lambda.has(inContext, cl))
						continue;
				default:
			}
			Reflect.setField(h, f, HxUnify.typeOf(Reflect.field(o, f), true, inContext));
		}
		return h;
	}
	#end
}