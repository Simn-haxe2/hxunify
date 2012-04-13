package hxunify;

import Type;
import hxunify.RuntimeType;

class Unificator 
{
	public var rt(default, null):RuntimeType;
	var unifyClassFields:Bool;
	
	public function new(unifyClassFields:Bool = false)
	{
		this.unifyClassFields = unifyClassFields;
	}
	
	public function unify(o:Dynamic)
	{
		if (rt == null) rt = HxUnify.typeOf(o, unifyClassFields, []);
		else rt = unifyRt(HxUnify.typeOf(o, unifyClassFields, []), rt);
		return rt;
	}
	
	function unifyValue(r1:ValueType, r2:ValueType):ValueType
	{
		return switch(r1)
		{
			case TNull:
				r2 == TNull ? TNull : TUnknown;
			case TInt:
				if (r2 == TInt || r2 == TFloat) r2;
				else TUnknown;
			case TFloat:
				if (r2 == TInt || r2 == TFloat) r1;
				else TUnknown;
			case TBool:
				if (r2 == TBool) r2;
				else TUnknown;
			case TUnknown:
				TUnknown;
			case TFunction:
				TFunction;
			case TEnum(en):
				unifyEnum(en, r2);
			case TClass(cl):
				throw "Unsupported";
			case TObject:
				ValueType.TObject;
		}
	}
	
	function unifyRt(r1:RuntimeType, r2:RuntimeType):RuntimeType
	{
		switch(r1)
		{
			case TValue(v1):
				switch(r2)
				{
					case TValue(v2):
						return TValue(unifyValue(v1, v2));
					default:
						return TValue(TUnknown);
				}
			case TIterable(b1, p1):
				switch(r2)
				{
					default:
						return TValue(TUnknown);
					case TIterable(b2, p2):
						if (b1 != b2)
							return TValue(TUnknown);
						return TIterable(b1, unifyRt(p1, p2));
				}
			case TObject(f1):
				switch(r2)
				{
					case TObject(f2):
						return RuntimeType.TObject(unifyFields(f1, f2));
					case TClass(c2, f2):
						if (!unifyClassFields)
							return TValue(TUnknown);
						var fields = unifyFields(f1, f2);
						return Reflect.fields(fields).length > 0 ? RuntimeType.TObject(fields) : TValue(TUnknown);
					default:
				}
				return TValue(TUnknown);
			case TClass(c1, f1):
				switch(r2)
				{
					case TClass(c2, f2):

						var uni = unifyClass(c1, TClass(c2));
						if (uni != null)
							return RuntimeType.TClass(uni, unifyClassFields ? unifyFields(f1, f2) : { } );
						else if (unifyClassFields)
						{
							var fields = unifyFields(f1, f2);
							return Reflect.fields(fields).length > 0  ? RuntimeType.TObject(fields) : TValue(TUnknown);							
						}
						else
							return TValue(TUnknown);
					case TObject(f2):
						if (!unifyClassFields)
							return TValue(TUnknown);						
						var fields = unifyFields(f1, f2);
						return Reflect.fields(fields).length > 0  ? RuntimeType.TObject(fields) : TValue(TUnknown);
					default:
						return TValue(TUnknown);
				}
				
		}
	}	
	
	function unifyClass(c1:Class<Dynamic>, rt:ValueType)
	{
		switch(rt)
		{
			case TClass(c2):
				var bc1 = c1;
				var bc2;
				do
				{
					bc2 = c2;
					do
					{
						if (bc1 == bc2) return bc1;
					} while ((bc2 = Type.getSuperClass(bc2)) != null);
				} while ((bc1 = Type.getSuperClass(bc1)) != null);
			default:
		}
		
		return null;
	}
	
	function unifyEnum(e1:Enum<Dynamic>, rt:ValueType)
	{
		switch(rt)
		{
			case TEnum(e2):
				if (Type.enumEq(e1, e2))
					return rt;
			default:
		}
		return TUnknown;
	}
	
	function unifyFields(f1:Dynamic<RuntimeType>, f2:Dynamic<RuntimeType>)
	{
		var uf:Dynamic<RuntimeType> = { };
		for (key in Reflect.fields(f1))
		{
			if (Reflect.hasField(f2, key))
				Reflect.setField(uf, key, unifyRt(Reflect.field(f1, key), Reflect.field(f2, key)));
		}
		return uf;
	}
}