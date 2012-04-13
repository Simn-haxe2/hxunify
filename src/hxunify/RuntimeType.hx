package hxunify;

enum RuntimeType
{
	TValue(v:Type.ValueType);
	TIterable(base:Class<Dynamic>, param:RuntimeType);
	TObject(fields:Dynamic<RuntimeType>);
	TClass(cl:Class<Dynamic>, fields:Dynamic<RuntimeType>);
}