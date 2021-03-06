
Strict

Import BRL.Stream
Import BRL.FileSystem
Import BRL.LinkedList
Import BRL.Hook

Const WORLDLIST_ENTITY    = 0
Const WORLDLIST_CAMERA    = 1
Const WORLDLIST_LIGHT     = 2
Const WORLDLIST_PIVOT     = 3
Const WORLDLIST_MESH      = 4
Const WORLDLIST_PLANE     = 5
Const WORLDLIST_TERRAIN   = 6
Const WORLDLIST_BODY      = 7
Const WORLDLIST_SPRITE    = 8
Const WORLDLIST_BONE      = 9
Const WORLDLIST_BSPMODEL  = 10
Const WORLDLIST_CUSTOM    = 11
Const WORLDLIST_TEXTURE   = 12
Const WORLDLIST_SHADER    = 13
Const WORLDLIST_BRUSH     = 14
Const WORLDLIST_RENDER    = 15
Const WORLDLIST_ARRAYSIZE = 16

Const MAX_COLLISION_TYPES=100

Type TWorldConfig
	Field Width,Height
	Field AmbientRed,AmbientGreen,AmbientBlue
	Field Wireframe,Dither
	
	Field TextureFilters$[][]

	Field ResourcePath$[], TmpResourcePath$
	
	Field UpdateHook= AllocHookId(), UpdateSpeed#
	
	Field List:TList[WORLDLIST_ARRAYSIZE]
	Field CollisionType:TList[MAX_COLLISION_TYPES]
	Field CollisionPairs:TList=CreateList()
	
	Method New()
		For Local i=0 To WORLDLIST_ARRAYSIZE-1
			List[i]=CreateList()
		Next
	End Method
	
	Method ProcessTextureFilters(path$,flags)
		For Local filter$[] = EachIn TextureFilters
			If path.Find(filter[0]) > -1 flags :| Int(filter[1])
		Next
		Return flags
	End Method
	
	Method AddObject:TLink(obj:Object,index)	
		Return List[index].AddLast(obj)
	End Method
	
	Method GetStream:Object(url:Object)
		Local stream:TStream=ReadStream(url)
		If stream Return stream
		If String(url)
			Local uri$=String(url),file$=StripDir(uri)
			For Local path$=EachIn ResourcePath+[TmpResourcePath]
				If path="" Continue
				stream=ReadStream(CasedFileName(path+"/"+file))
				If stream Return stream
			Next
			stream=ReadStream(CasedFileName(file))
			If stream Return stream
			Return url
		EndIf 
		Return url
	End Method
End Type

