package ;

import haxe.FastList;
import Type;
import hxunify.RuntimeType;

using hxunify.HxUnify;

class TestEquality extends haxe.unit.TestCase
{
	public function testTValueNull()
	{
		assertTrue(TValue(TNull).equals(TValue(TNull)));
		assertFalse(TValue(TNull).equals(TValue(TInt)));
		assertFalse(TValue(TNull).equals(TValue(TFloat)));
		assertFalse(TValue(TNull).equals(TValue(TBool)));
		assertFalse(TValue(TNull).equals(TValue(TUnknown)));
		assertFalse(TValue(TNull).equals(TValue(TObject)));
		assertFalse(TValue(TNull).equals(TValue(TFunction)));
		assertFalse(TValue(TNull).equals(TValue(TClass(C))));
		assertFalse(TValue(TNull).equals(TValue(TEnum(E))));
	}
	
	public function testTValueInt()
	{
		assertTrue(TValue(TInt).equals(TValue(TInt)));
		assertFalse(TValue(TInt).equals(TValue(TNull)));
		assertFalse(TValue(TInt).equals(TValue(TFloat)));
		assertFalse(TValue(TInt).equals(TValue(TBool)));
		assertFalse(TValue(TInt).equals(TValue(TUnknown)));
		assertFalse(TValue(TInt).equals(TValue(TObject)));
		assertFalse(TValue(TInt).equals(TValue(TFunction)));
		assertFalse(TValue(TInt).equals(TValue(TClass(C))));
		assertFalse(TValue(TInt).equals(TValue(TEnum(E))));
	}	
	
	public function testTValueFloat()
	{
		assertTrue(TValue(TFloat).equals(TValue(TFloat)));
		assertFalse(TValue(TFloat).equals(TValue(TNull)));
		assertFalse(TValue(TFloat).equals(TValue(TInt)));
		assertFalse(TValue(TFloat).equals(TValue(TBool)));
		assertFalse(TValue(TFloat).equals(TValue(TUnknown)));
		assertFalse(TValue(TFloat).equals(TValue(TObject)));
		assertFalse(TValue(TFloat).equals(TValue(TFunction)));
		assertFalse(TValue(TFloat).equals(TValue(TClass(C))));
		assertFalse(TValue(TFloat).equals(TValue(TEnum(E))));
	}
	
	public function testTValueBool()
	{
		assertTrue(TValue(TBool).equals(TValue(TBool)));
		assertFalse(TValue(TBool).equals(TValue(TNull)));
		assertFalse(TValue(TBool).equals(TValue(TInt)));
		assertFalse(TValue(TBool).equals(TValue(TFloat)));
		assertFalse(TValue(TBool).equals(TValue(TUnknown)));
		assertFalse(TValue(TBool).equals(TValue(TObject)));
		assertFalse(TValue(TBool).equals(TValue(TFunction)));
		assertFalse(TValue(TBool).equals(TValue(TClass(C))));
		assertFalse(TValue(TBool).equals(TValue(TEnum(E))));
	}	
	
	public function testTValueUnknown()
	{
		assertTrue(TValue(TUnknown).equals(TValue(TUnknown)));
		assertFalse(TValue(TUnknown).equals(TValue(TNull)));
		assertFalse(TValue(TUnknown).equals(TValue(TInt)));
		assertFalse(TValue(TUnknown).equals(TValue(TFloat)));
		assertFalse(TValue(TUnknown).equals(TValue(TBool)));
		assertFalse(TValue(TUnknown).equals(TValue(TObject)));
		assertFalse(TValue(TUnknown).equals(TValue(TFunction)));
		assertFalse(TValue(TUnknown).equals(TValue(TClass(C))));
		assertFalse(TValue(TUnknown).equals(TValue(TEnum(E))));
	}
	
	public function testTValueObject()
	{
		assertTrue(TValue(TObject).equals(TValue(TObject)));
		assertFalse(TValue(TObject).equals(TValue(TNull)));
		assertFalse(TValue(TObject).equals(TValue(TInt)));
		assertFalse(TValue(TObject).equals(TValue(TFloat)));
		assertFalse(TValue(TObject).equals(TValue(TBool)));
		assertFalse(TValue(TObject).equals(TValue(TUnknown)));
		assertFalse(TValue(TObject).equals(TValue(TFunction)));
		assertFalse(TValue(TObject).equals(TValue(TClass(C))));
		assertFalse(TValue(TObject).equals(TValue(TEnum(E))));
	}		
	
	public function testTValueFunction()
	{
		assertTrue(TValue(TFunction).equals(TValue(TFunction)));
		assertFalse(TValue(TFunction).equals(TValue(TNull)));
		assertFalse(TValue(TFunction).equals(TValue(TInt)));
		assertFalse(TValue(TFunction).equals(TValue(TFloat)));
		assertFalse(TValue(TFunction).equals(TValue(TBool)));
		assertFalse(TValue(TFunction).equals(TValue(TUnknown)));
		assertFalse(TValue(TFunction).equals(TValue(TObject)));
		assertFalse(TValue(TFunction).equals(TValue(TClass(C))));
		assertFalse(TValue(TFunction).equals(TValue(TEnum(E))));
	}	
	
	public function testTValueClass()
	{
		assertTrue(TValue(TClass(C)).equals(TValue(TClass(C))));
		assertFalse(TValue(TClass(C)).equals(TValue(TClass(D))));
		assertFalse(TValue(TClass(C)).equals(TValue(TNull)));
		assertFalse(TValue(TClass(C)).equals(TValue(TInt)));
		assertFalse(TValue(TClass(C)).equals(TValue(TFloat)));
		assertFalse(TValue(TClass(C)).equals(TValue(TBool)));
		assertFalse(TValue(TClass(C)).equals(TValue(TUnknown)));
		assertFalse(TValue(TClass(C)).equals(TValue(TFunction)));
		assertFalse(TValue(TClass(C)).equals(TValue(TObject)));
		assertFalse(TValue(TClass(C)).equals(TValue(TEnum(E))));
	}		
	
	public function testTValueEnum()
	{
		assertTrue(TValue(TEnum(E)).equals(TValue(TEnum(E))));
		assertFalse(TValue(TEnum(E)).equals(TValue(TEnum(F))));
		assertFalse(TValue(TEnum(E)).equals(TValue(TNull)));
		assertFalse(TValue(TEnum(E)).equals(TValue(TInt)));
		assertFalse(TValue(TEnum(E)).equals(TValue(TFloat)));
		assertFalse(TValue(TEnum(E)).equals(TValue(TBool)));
		assertFalse(TValue(TEnum(E)).equals(TValue(TUnknown)));
		assertFalse(TValue(TEnum(E)).equals(TValue(TFunction)));
		assertFalse(TValue(TEnum(E)).equals(TValue(TObject)));
		assertFalse(TValue(TEnum(E)).equals(TValue(TClass(C))));
	}
	
	public function testIterable()
	{
		assertTrue(TIterable(Array, TValue(TInt)).equals(TIterable(Array, TValue(TInt))));
		assertFalse(TIterable(Array, TValue(TInt)).equals(TIterable(List, TValue(TInt))));
		assertFalse(TIterable(Array, TValue(TInt)).equals(TIterable(Array, TValue(TFloat))));
	}
	
	public function testObject()
	{
		var o1Hash:Dynamic<RuntimeType> = {};
		var o2Hash:Dynamic<RuntimeType> = {};
		assertTrue(RuntimeType.TObject(o1Hash).equals(RuntimeType.TObject(o2Hash)));
		o1Hash.foo = TValue(TInt);
		assertFalse(RuntimeType.TObject(o1Hash).equals(RuntimeType.TObject(o2Hash)));
		o2Hash.foo = TValue(TFloat);
		assertFalse(RuntimeType.TObject(o1Hash).equals(RuntimeType.TObject(o2Hash)));	
		o2Hash.foo = TValue(TInt);
		assertTrue(RuntimeType.TObject(o1Hash).equals(RuntimeType.TObject(o2Hash)));
		o2Hash.bar = TValue(TInt);
		assertFalse(RuntimeType.TObject(o1Hash).equals(RuntimeType.TObject(o2Hash)));			
	}
	
	public function testClass()
	{
		assertTrue(RuntimeType.TClass(C, null).equals(RuntimeType.TClass(C, null)));
		assertFalse(RuntimeType.TClass(C, null).equals(RuntimeType.TClass(D, null)));
	}
	
	public function testIsIterable()
	{
		assertTrue([1].isIterable());
		assertTrue([].isIterable());
		assertFalse(1.isIterable());
		var d:Dynamic = [""];
		assertTrue(d.isIterable());
		var l = new List();
		assertTrue(l.isIterable());
		var h = new Hash();
		assertTrue(h.isIterable());
		var i = new IntHash();
		assertTrue(i.isIterable());
		var f = new FastList<String>();
		assertTrue(f.isIterable());
	}	
}

class C { }
class D { }
enum E { E1; }
enum F { E1; }