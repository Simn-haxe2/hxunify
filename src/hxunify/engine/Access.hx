package hxunify.engine;

class Access 
{
	static public function asValue(rt:RuntimeType)
	{
		switch(rt)
		{
			case TValue(t):
				return t;
			default:
				throw "Expected ValueType but found " +rt;
		}
	}
	
	static public function asClass(rt:RuntimeType)
	{
		switch(rt)
		{
			case TClass(c, f):
				return c;
			case TIterable(c, p):
				return c;
			default:
				throw "Expected class but found " +rt;
		}
	}
	
	static public function asObject(rt:RuntimeType)
	{
		switch(rt)
		{
			case TObject(f):
				return f;
			case TClass(c, f):
				return f;
			default:
				throw "Expected class or object but found " +rt;
		}
	}
	
	static public function asIterableParam(rt:RuntimeType)
	{
		switch(rt)
		{
			case TIterable(b, p):
				return p;
			default:
				throw "Expected iterable but found " +rt;
		}
	}
}