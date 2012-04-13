package hxunify.engine;

class Equality 
{
	static public function equals(rt1:RuntimeType, rt2:RuntimeType, ?compareClassFields = false)
	{
		switch(rt1)
		{
			case TValue(v1):
				switch(rt2)
				{
					case TValue(v2):
						switch(v1)
						{
							case TClass(c1):
								switch(v2)
								{
									case TClass(c2): return c1 == c2;
									default: return false;
								}
							case TEnum(e1):
								switch(v2)
								{
									case TEnum(e2): return e1 == e2;
									default: return false;
								}
							default:
								return v1 == v2;
						}
					default: return false;
				}
			case TIterable(c1, p1):
				switch(rt2)
				{
					case TIterable(c2, p2): return c1 == c2 && equals(p1, p2);
					default: return false;
				}
			case TObject(f1):
				switch(rt2)
				{
					case TObject(f2):
						return fieldsEqual(f1, f2);
					default:
						return false;
				}
			case TClass(c1, f1):
				switch(rt2)
				{
					case TClass(c2, f2): return c1 == c2 && (!compareClassFields || fieldsEqual(f1, f2));
					default: return false;
				}
		}
	}
	
	static function fieldsEqual(f1:Dynamic, f2:Dynamic)
	{
		if (f1 == null)
			return f2 == null;
		else if (f2 == null)
			return false;
			
		if (Reflect.fields(f1).length != Reflect.fields(f2).length)
			return false;
		for (key in Reflect.fields(f1))
		{
			if (!Reflect.hasField(f2, key)) return false;
			if (!equals(Reflect.field(f1, key), Reflect.field(f2, key))) return false;
		}
		return true;
	}
}