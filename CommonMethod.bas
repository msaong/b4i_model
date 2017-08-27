Type=StaticCode
Version=4.28
ModulesStructureVersion=1
B4i=true
@EndOfDesignText@
'Code module

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
End Sub
Public Sub SetButtonTextColor(btn As Button, clr As Int, state As Int)
	'更改按钮文字颜色
	'state: 0 = normal, 1 = pressed, 2 = disabled
   Dim no As NativeObject = btn
   no.RunMethod("setTitleColor:forState:", Array(no.ColorToUIColor(clr), state))
End Sub
Sub SetBackgroundImage(b As Button, bmp As Bitmap, state As Int)
	'更高按钮背景图片
    Dim no As NativeObject = b
    no.RunMethod("setBackgroundImage:forState:", Array(bmp, state))
End Sub
Sub GetAppName As String
	'获取APP名字
   Dim no As NativeObject
   no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)
   Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array("CFBundleDisplayName"))
   Return name
End Sub

Sub GetVersion As String
	'获取APP版本
   Dim no As NativeObject
   no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)
   Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array("CFBundleShortVersionString"))
   Return name
End Sub

Sub SetTitleColor(nav As NavigationController, clr As Int)
	'设置顶部标题文字颜色
   Dim attributes As NativeObject
   attributes = attributes.Initialize("B4IAttributedString").RunMethod("createAttributes::", _
     Array(Font.CreateNew(18), attributes.ColorToUIColor(clr)))
   Dim no As NativeObject = nav
   no.GetField("navigationBar").RunMethod("setTitleTextAttributes:", Array(attributes))
End Sub
Sub SetTitleBackgroundColor(nav As NavigationController, clr As Int)
	'设置顶部toolbar和导航栏背景颜色
   Dim OBJNavBar As NativeObject = Main.NavControl
   OBJNavBar.GetField("toolbar").RunMethod("setBarTintColor:", Array(OBJNavBar.ColorToUIColor(clr)))
   OBJNavBar.GetField("navigationBar").RunMethod("setBarTintColor:", Array(OBJNavBar.ColorToUIColor(clr)))
   OBJNavBar.GetField("navigationBar").SetField("translucent", False)
End Sub