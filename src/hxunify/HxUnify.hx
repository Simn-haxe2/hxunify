package hxunify;
import haxe.macro.Expr;

typedef Acc = hxunify.engine.Access;
typedef Eq = hxunify.engine.Equality;
typedef Fld = hxunify.engine.Fields;
typedef Uni = hxunify.Unificator;
typedef Rtv = hxunify.RuntimeType;

class HxUnify
{
	static public function unify(it:Iterable<Dynamic>, unifyClassFields = false):RuntimeType
	{
		var inst = new Unificator(unifyClassFields);
		for (el in it)
			inst.unify(el);

		if (inst.rt == null) return TValue(TUnknown);
		return inst.rt;
	}
	
	static public function typeOf(o:Dynamic, unifyClassFields = false, ?inContext:Array<Dynamic>):RuntimeType
	{
		if (inContext == null) inContext = [];
		var t = Type.typeof(o);
		switch(t)
		{
			case TObject:
				var ctx = inContext.copy();
				return TObject(Fld.getFields(o, ctx, unifyClassFields).fields);
			case TClass(cl):
				var ctx = inContext.copy();
				ctx.push(cl);

				var fields = { };
				if (unifyClassFields)
				{
					#if flash9
						fields = Fld.getClassFields(o, cl, ctx, true);
					#else
						var nFields = Fld.getFields(o, ctx, true);
						//for (circular in nFields.circular)
							//Reflect.setField(nFields.fields, circular, type);
						fields = cast nFields.fields;
					#end
				}
	
				if (isIterable(o))
					return TIterable( { classType: cl, fields: cast fields }, unify(o, unifyClassFields));
				else
					return TClass( { classType:cl, fields: cast fields } );
			default:
				return TValue(t);
		}
	}
	
	static public function isIterable(o:Dynamic):Bool
	{
		try { if (o.iterator != null && o.iterator() != null && o.iterator().hasNext != null && o.iterator().next != null)
			return true;
		} catch (e:Dynamic) { }
		return false;
	}

	static public function toString(rt:RuntimeType)
	{
		switch(rt)
		{
			case TValue(v): return Std.string(v);
			case TIterable(b, p): return Std.string(b) + "<" +toString(p) + ">";
			case TClass(c): return Std.string(c.classType);
			case TObject(f): return Std.string(f);
		}
	}
}