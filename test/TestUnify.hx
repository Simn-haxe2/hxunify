package ;

import Type;
import hxunify.RuntimeType;

using hxunify.HxUnify;
using Lambda;

class TestUnify extends haxe.unit.TestCase
{
	var a:Array<Dynamic>;
	
	public function testEmpty()
	{
		assertEquals(TUnknown, [].unify().asValue());
	}
	
	public function testSingleInt()
	{
		assertEquals(TInt, [1].unify().asValue());
	}
	
	public function testSingleFloat()
	{
		assertEquals(TFloat, [1.2].unify().asValue());
	}
	
	public function testSingleBool()
	{
		assertEquals(TBool, [true].unify().asValue());
	}
	
	public function testSingleNull()
	{
		assertEquals(TNull, [null].unify().asValue());
	}
		
	public function testMultipleInt()
	{
		assertEquals(TInt, [1, 9].unify().asValue());
	}
	
	public function testMultipleFloat()
	{
		assertEquals(TFloat, [1.2, 2.4].unify().asValue());
	}
	
	public function testMutipleBool()
	{
		assertEquals(TBool, [true, false].unify().asValue());
	}
	
	public function testMultipleNull()
	{
		assertEquals(TNull, [null, null].unify().asValue());
	}
	
	public function testFloatInt()
	{
		assertEquals(TFloat, [1, 2.2].unify().asValue());
	}

	public function testStringInt()
	{
		a = ["1", 1];
		assertEquals(TUnknown, a.unify().asValue());
	}
	
	public function testSingleClass()
	{
		assertEquals(Base, [new Base()].unify().asClass());
	}

	public function testMultipleClass()
	{
		assertEquals(Base, [new Base(), new Base()].unify().asClass());
	}
	
	public function testCommonBaseClass1()
	{
		assertEquals(Base, [new Base(), new Child1()].unify().asClass());
	}
	
	public function testCommonBaseClass2()
	{
		assertEquals(Base, [new Child2(), new Child1()].unify().asClass());
	}
	
	public function testCommonBaseClass3()
	{
		assertEquals(Base, [new Child2(), new Child1(), new Child2_1()].unify().asClass());
	}
	
	public function testUnrelatedClass()
	{
		a = [new Child2(), new Child1(), new Child2_1(), new Unrelated()];
		assertEquals(TUnknown, a.unify().asValue());
	}
	
	public function testSingleEnum()
	{
		assertTrue([A.A1].unify().equals(TValue(TEnum(A))));
	}
	
	public function testMultipleEnum()
	{
		assertTrue([A.A1, A.A2].unify().equals(TValue(TEnum(A))));
	}
	
	public function testUnrelatedEnum()
	{
		a = [A.A1, B.B1];
		assertEquals(TUnknown, a.unify().asValue());
	}
	
	public function testFromSerialization()
	{
		var arr = [new Child2(), new Child1(), new Child2_1()];
		var ser = haxe.Serializer.run(arr);
		var unser = haxe.Unserializer.run(ser);
		assertEquals(Base, hxunify.HxUnify.unify(unser).asClass());
	}
	
	public function testUnrelatedFromSerialization()
	{
		var arr:Array<Dynamic> = [new Child2(), new Child1(), new Child2_1(), new Unrelated()];
		var ser = haxe.Serializer.run(arr);
		var unser = haxe.Unserializer.run(ser);
		assertEquals(TUnknown, hxunify.HxUnify.unify(unser).asValue());		
	}
	
	public function testArrayInt()
	{
		var arr = [ [1, 2], [3, 4] ];
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(Array), TValue(TInt))));
	}
	
	public function testArrayFloat()
	{
		var arr = [ [1.6, 2.2], [3.9, 4.1] ];
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(Array), TValue(TFloat))));
	}	
	
	public function testArrayBool()
	{
		var arr = [ [false, false], [true, true] ];
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(Array), TValue(TBool))));
	}	
	
	public function testArrayNull()
	{
		var arr = [ [null, null], [null, null] ];
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(Array), TValue(TNull))));
	}	
	
	public function testArraySameClass()
	{
		var arr = [ [ new Base() ], [ new Base(), new Base() ] ];
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(Array), RuntimeType.TClass(makeRuntimeClass(Base)))));
	}
	
	public function testArrayCommonBaseClass1()
	{
		var arr:Array<Dynamic> = [ [ new Child1() ], [ new Child2(), new Child2_1() ] ];
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(Array), RuntimeType.TClass(makeRuntimeClass(Base)))));
	}	
	
	public function testArrayCommonBaseClass2()
	{
		var arr = [ [ new Child2() ], [ new Child2_1(), new Child2() ] ];
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(Array), RuntimeType.TClass(makeRuntimeClass(Child2)))));
	}		
	
	public function testArrayUnrelated()
	{
		a = [new Unrelated(), new Child2()];
		var arr:Array<Dynamic> = [ [ new Child2() ], a ];
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(Array), TValue(TUnknown))));
	}
	
	public function testListInt()
	{
		var arr = [ [1, 2].list(), [3, 4].list() ].list();
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(List), TValue(TInt))));
	}

	public function testListFloat()
	{
		var arr = [ [1.6, 2.2].list(), [3.9, 4.1].list() ].list();
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(List), TValue(TFloat))));
	}
	
	
	public function testListBool()
	{
		var arr = [ [false, false].list(), [true, true].list() ].list();
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(List), TValue(TBool))));
	}	
	
	public function testListNull()
	{
		var arr = [ [null, null].list(), [null, null].list() ].list();
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(List), TValue(TNull))));
	}	
	
	public function testListSameClass()
	{
		var arr = [ [ new Base() ].list(), [ new Base(), new Base() ].list() ].list();
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(List), RuntimeType.TClass(makeRuntimeClass(Base)))));
	}
	
	public function testListCommonBaseClass1()
	{
		var l:List<Dynamic> = [ new Child1(), new Base() ].list();
		var arr:List<List<Dynamic>> = [ [ new Child2() ].list(), l].list();
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(List), RuntimeType.TClass(makeRuntimeClass(Base)))));
	}	
	
	public function testListCommonBaseClass2()
	{
		var arr = [ [ new Child2() ].list(), [ new Child2_1(), new Child2() ].list() ].list();
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(List), RuntimeType.TClass(makeRuntimeClass(Child2)))));
	}		
	
	public function testListUnrelated()
	{
		a = [ new Unrelated(), new Child2() ];
		var arr:List<List<Dynamic>> = [ [ new Child2() ].list(), a.list()].list();
		assertTrue(arr.unify().equals(TIterable(makeRuntimeClass(List), TValue(TUnknown))));
	}	
	
	public function testHashInt()
	{
		var hash = new Hash();
		hash.set("1", 1);
		hash.set("2", 9);
		hash.set("3", 22);
		assertEquals(TInt, hash.unify().asValue());
	}	
	
	public function testHashFloat()
	{
		var hash = new Hash();
		hash.set("1", 1.3);
		hash.set("2", 9.6);
		hash.set("3", 22.4);
		assertEquals(TFloat, hash.unify().asValue());
	}		
	
	public function testHashBool()
	{
		var hash = new Hash();
		hash.set("1", true);
		hash.set("2", false);
		hash.set("3", true);
		assertEquals(TBool, hash.unify().asValue());
	}		
	
	public function testHashNull()
	{
		var hash = new Hash();
		hash.set("1", null);
		hash.set("2", null);
		hash.set("3", null);
		assertEquals(TNull, hash.unify().asValue());
	}		
	
	public function testIntHashInt()
	{
		var hash = new IntHash();
		hash.set(1, 1);
		hash.set(2, 9);
		hash.set(3, 22);
		assertEquals(TInt, hash.unify().asValue());
	}	
	
	public function testIntHashFloat()
	{
		var hash = new IntHash();
		hash.set(1, 1.3);
		hash.set(2, 9.6);
		hash.set(3, 22.4);
		assertEquals(TFloat, hash.unify().asValue());
	}		
	
	public function testIntHashBool()
	{
		var hash = new IntHash();
		hash.set(1, true);
		hash.set(2, false);
		hash.set(3, true);
		assertEquals(TBool, hash.unify().asValue());
	}		
	
	public function testIntHashNull()
	{
		var hash = new IntHash();
		hash.set(1, null);
		hash.set(2, null);
		hash.set(3, null);
		assertEquals(TNull, hash.unify().asValue());
	}
	
	public function testAnonymousObject()
	{
		var comp = { foo: TValue(TFloat) };
		assertTrue([ { foo:9 }, { foo: 39.2 } ].unify().equals(RuntimeType.TObject(comp)));
		a = [ { foo:9, bar:"bar" }, { foo: 39.2 } ];
		assertTrue(a.unify().equals(RuntimeType.TObject(comp)));
		a = [ { foo:9, bar:"bar" }, { foo: 39.2, unk:"bar" } ];
		assertTrue(a.unify().equals(RuntimeType.TObject(comp)));
	}
	
	public function testClassCommonField()
	{
		var comp = { bar: TValue(TFloat) };
		a = [new CommonField(), new Child2()];
		assertTrue(a.unify(true).equals(RuntimeType.TObject(comp)));
		a = [new CommonField(), new Child1()];
		assertFalse(a.unify(true).equals(RuntimeType.TObject(comp)));
	}
	
	public function testClassToObject()
	{
		var comp = { bar: TValue(TInt) };
		a = [new Child2(), { bar:99 } ];
		assertTrue(a.unify(true).equals(RuntimeType.TObject(comp)));
		a = [new Child1(), { bar:99 } ];
		assertFalse(a.unify(true).equals(RuntimeType.TObject(comp)));
		a = [new Child2(), { bar:99, foo:"foo" } ];
		assertFalse(a.unify(true).equals(RuntimeType.TObject(comp)));
	}
	
	public function testRecursiveClass()
	{
		var c1 = new SelfCircular();
		var c2 = new SelfCircular();
		c1.next = c2;
		
		assertEquals(SelfCircular, [c1, c1.next].unify().asClass());
	}
	
	public function testCircularClasses()
	{
		var c1 = new Circular1();
		var c2 = new Circular2();
		c1.partner = c2;
		c2.partner = c1;
		
		assertEquals(Circular1, [c1, c2.partner].unify().asClass());
		assertEquals(Circular2, [c2, c1.partner].unify().asClass());
	}
	
	public function testIterators()
	{
		assertEquals(PseudoIterator, [new PseudoIterator()].unify().asClass());
		assertEquals(NullIterator, [new NullIterator()].unify().asClass());
		assertTrue(TIterable(makeRuntimeClass(RealIterator), TValue(TInt)).equals([new RealIterator()].unify()));
	}
	
	#if flash9
	public function testApi()
	{
		
		assertEquals(flash.display.Sprite, [new flash.display.MovieClip(), new flash.display.Sprite()].unify().asClass());
		assertEquals(flash.display.DisplayObject, [new flash.display.MovieClip(), new flash.display.Bitmap()].unify().asClass());
	}
	#end
	
	function makeRuntimeClass(cl:Class<Dynamic>):RuntimeClass
		return { classType:cast cl, fields: cast { } }
}

class Base { public function new() { } }
class Child1 extends Base { public function new() { super(); foo = 20; } var foo:Int; }
class Child2 extends Base { public function new() { super(); bar = 2; foo = 0.3; } var bar:Int; var foo:Float; }
class Child2_1 extends Child2 { public function new() { super(); } }
class Unrelated { public function new() { } }
class CommonField { public function new() { bar = 0.2; } var bar:Float; }
class SelfCircular { public function new() { } public var next:SelfCircular; }
class Circular1 { public function new() { } public var partner:Circular2; }
class Circular2 { public function new() { } public var partner:Circular1; }
class NullIterator { public function new() { } public function iterator() return null }
class PseudoIterator { public function new() { } public function iterator() return "foo" }
class RealIterator { static var a = [1];  public function new() { } public function iterator() return a.iterator() }

enum A
{
	A1;
	A2;
}

enum B
{
	B1;
}