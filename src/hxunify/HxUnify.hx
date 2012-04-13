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

				if (isIterable(o))
					return TIterable(cl, unify(o, unifyClassFields));

				if (!unifyClassFields)
					return TClass(cl, { } );
						
				#if flash9
					return TClass(cl, Fld.getClassFields(o, cl, ctx, true));
				#else
					var fields = Fld.getFields(o, ctx, true);
					var type = TClass(cl, fields.fields);
					for (circular in fields.circular)
						Reflect.setField(fields.fields, circular, type);
					return type;
				#end
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
			case TClass(c, f): return Std.string(c);
			case TObject(f): return Std.string(f);
		}
	}
}